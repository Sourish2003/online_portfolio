const sharp = require('sharp');
const fs = require('fs');

const svgBuffer = fs.readFileSync('./web/icon.svg');

const sizes = [
  { size: 16, name: 'favicon.png' },
  { size: 32, name: 'favicon-32x32.png' },
  { size: 180, name: 'apple-touch-icon.png' },
  { size: 192, name: 'icons/Icon-192.png' },
  { size: 512, name: 'icons/Icon-512.png' },
  { size: 192, name: 'icons/Icon-maskable-192.png' },
  { size: 512, name: 'icons/Icon-maskable-512.png' }
];

async function generateIcons() {
  for (const { size, name } of sizes) {
    await sharp(svgBuffer)
      .resize(size, size)
      .png()
      .toFile(`./web/${name}`);
    console.log(`Generated ${name} (${size}x${size})`);
  }
  console.log('All icons generated successfully!');
}

generateIcons().catch(console.error);
