const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const fs = require("fs").promises;
const path = require("path");

// Initialize Firebase Admin
initializeApp();

/**
 * Reads the HTML email template from the filesystem.
 * @return {Promise<string>} The contents of the email template.
 */
async function getEmailTemplate() {
  const templatePath = path.join(__dirname, "email-template.html");
  const template = await fs.readFile(templatePath, "utf8");
  return template;
}

/**
 * Replaces template variables with actual data.
 * @param {string} template The HTML template string.
 * @param {Object} data The data object containing replacement values.
 * @param {string} data.name The name of the sender.
 * @param {string} data.email The email of the sender.
 * @param {string} data.message The message content.
 * @return {string} The template with variables replaced.
 */
function replaceTemplateVariables(template, data) {
  return template
      .replace("{{name}}", data.name || "")
      .replace("{{email}}", data.email || "")
      .replace("{{message}}", data.message || "");
}

/**
 * Cloud Function triggered when a new contact form submission is created.
 * Sends an email using the Firebase Email Extension.
 */
exports.onContactSubmission = onDocumentCreated(
    "contact_submissions/{docId}",
    async (event) => {
      const snapshot = event.data;
      if (!snapshot) {
        console.log("No data associated with the event");
        return;
      }

      const data = snapshot.data();

      try {
        // Get the email template
        const template = await getEmailTemplate();

        // Replace variables in the template
        const htmlContent = replaceTemplateVariables(template, data);

        const mailCollection = getFirestore().collection("mail");
        const timestamp = new Date().getTime();
        const messageId = `portfolio-contact-${timestamp}@${event.params.docId}`;

        // Send notification email to admin (you)
        await mailCollection.add({
          to: ["sourish666@gmail.com"],
          from: data.email,
          replyTo: data.email,
          message: {
            subject: "New Portfolio Contact Form Submission",
            html: htmlContent,
            messageId: messageId,
          },
        });

        // Send confirmation email to the user
        await mailCollection.add({
          to: [data.email],
          message: {
            subject: "Thank you for contacting me",
            html: `
              <div style="font-family: Arial, sans-serif; padding: 20px; color: #333;">
                <h2>Thank you for reaching out!</h2>
                <p>Dear ${data.name},</p>
                <p>I have received your message and will get back to you as soon as possible.</p>
                <p>For your reference, here's what you sent:</p>
                <blockquote style="margin: 20px; padding: 10px; border-left: 4px solid #ccc;">
                  ${data.message}
                </blockquote>
                <p>Best regards,<br>Sourish</p>
              </div>
            `,
            messageId: `reply-${messageId}`,
            inReplyTo: messageId,
            references: [messageId],
          },
        });

        console.log("Emails sent successfully");
      } catch (error) {
        console.error("Error in sendContactEmail:", error);
        throw error;
      }
    });
