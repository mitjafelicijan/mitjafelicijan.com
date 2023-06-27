---
title: Create placeholder images with sharp Node.js image processing library
url: create-placeholder-images-with-sharp.html
date: 2020-03-27T12:00:00+02:00
draft: false
---

I have been searching for a solution to pre-generate some placeholder images for
image server I needed to develop that resizes images on S3. I though this would
be a 15min job and quickly found out how very mistaken I was.

Even though Node.js is not really the best way to do this kind of things (surely
something written in C or Rust or even Golang would be the correct way to do
this but we didn't need the speed in our case) I found an excellent library
[sharp - High performance Node.js image
processing](https://github.com/lovell/sharp).

Getting things running was a breeze.

## Fetch image from S3 and save resized

```js
const sharp = require('sharp');
const aws = require('aws-sdk');

const x,y = 100;
const s3 = new aws.S3({});

aws.config.update({
  secretAccessKey: 'secretAccessKey',
  accessKeyId: 'accessKeyId',
  region: 'region'
});

const originalImage = await s3.getObject({
  Bucket: 'some-bucket-name',
  Key: 'image.jpg',
}).promise();

const resizedImage = await sharp(originalImage.Body)
  .resize(x, y)
  .jpeg({ progressive: true })
  .toBuffer();

s3.putObject({
  Bucket: 'some-bucket-name',
  Key: `optimized/${x}x${y}/image.jpg`,
  Body: resizedImage,
  ContentType: 'image/jpeg',
  ACL: 'public-read'
}).promise();
```

All this code was wrapped inside a web service with some additional security 
checks and defensive coding to detect if key is missing on S3.

And at that point I needed to return placeholder images as a response in case
key is missing or x,y are not allowed by the server etc. I could have created
PNG in Gimp and just serve them but I wanted to respect aspect ratio and I
didn't want to return some mangled images.

> Main problem with finding a clean solution I could copy and paste and change a
> bit was a task. API is changing constantly and there weren't clear examples or
> I was unable to find them.

## Generating placeholder images using SVG

What I ended up was using SVG to generate text and created image with sharp and
used composition to combine both layers. Response returned by this function is a
buffer you can use to either upload to S3 or save to local file.

```js
const generatePlaceholderImageWithText = async (width, height, message) => {
  const overlay = `<svg width="${width - 20}" height="${height - 20}">
    <text x="50%" y="50%" font-family="sans-serif" font-size="16" text-anchor="middle">${message}</text>
  </svg>`;

  return await sharp({
    create: {
      width: width,
      height: height,
      channels: 4,
      background: { r: 230, g: 230, b: 230, alpha: 1 }
    }
  })
    .composite([{
      input: Buffer.from(overlay),
      gravity: 'center',
    }])
    .jpeg()
    .toBuffer();
}
```

That is about it. Nothing more to it. You can change the color of the image by
changing `background` and if you want to change text styling you can adapt SVG
to your needs.

> Also be careful about the length of the text. This function positions text at
> the center and adds `20px` padding on all sides. If text is longer than the
> image it will get cut.
