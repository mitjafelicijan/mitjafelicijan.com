window.addEventListener('load', async () => {
  // dither image on mouse over replace
  // document.querySelectorAll('article img').forEach(img => {
  //   const ditheredImage = img.src;
  //   const originalImage = img.src.replace('.dith.gif', '');

  //   img.addEventListener('mouseover', evt => {
  //     evt.target.src = originalImage;
  //   });

  //   img.addEventListener('mouseout', evt => {
  //     evt.target.src = ditheredImage;
  //   });
  // });

  // flip CV image on mouse over
  const cvImage = document.querySelector('.cv-picture img');
  if (cvImage) {
    cvImage.addEventListener('mouseover', evt => {
      evt.target.style.transform = 'scaleX(-1)';
    });

    cvImage.addEventListener('mouseout', evt => {
      evt.target.style.transform = 'scaleX(1)';
    });
  }

  // comments code
  const commentsEndpoint = 'https://mitjafelicijan.com/comments-api';
  const commentsPlaceholder = document.querySelector('.comments');

  if (commentsPlaceholder) {
    const guid = commentsPlaceholder.dataset.guid;
    const name = commentsPlaceholder.querySelector('input');
    const comment = commentsPlaceholder.querySelector('textarea');
    const submit = commentsPlaceholder.querySelector('button');
    const comments = commentsPlaceholder.querySelector('ul');

    if (guid) {
      await readAndRenderComments(guid, comments);

      submit.addEventListener('click', async() => {
        submit.disabled = true;
        await writeComments(guid, name.value, comment.value);

        submit.disabled = false;
        name.value = '';
        comment.value = '';

        await readAndRenderComments(guid, comments);
      });
    }
  }

  async function writeComments(guid, name, comment) {
    const response = await fetch(commentsEndpoint, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        action: 'write',
        guid,
        name,
        comment,
      })
    });
  }

  async function readAndRenderComments(guid, commentsPlaceholder) {
    const response = await fetch(commentsEndpoint, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        action: 'read',
        guid,
      })
    });

    // remove all existing comments from list
    commentsPlaceholder.innerHTML = '';

    const commentList = await response.json();
    for (const comment of commentList.reverse()) {
      const date = new Date(comment.date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        hour: 'numeric',
        minute: 'numeric'
      });

      const commentElement = document.createElement('li');
      commentElement.innerHTML = `<p><b>${comment.name}</b> - ${date}<p><p>${comment.comment}<p><hr>`;
      commentsPlaceholder.appendChild(commentElement);
    }
  }

});
