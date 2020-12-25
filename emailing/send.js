const fs = require('fs');
// const path = require('path');
const axios = require('axios');
const dayjs = require('dayjs');
const weekOfYear = require('dayjs/plugin/weekOfYear');
const handlebars = require('handlebars');
const yesno = require('yesno');

dayjs.extend(weekOfYear);

(async function () {

  //const campaignId = 'b03de6fc-ff95-40a0-8707-c0706b3c0b31'; // production
  //const campaignId = '2bbcdedb-49d8-48f3-9f33-df6e04c9e5bf'; // testing
  const from = { name: 'Mitja Felicijan', email: 'weekly@mitjafelicijan.com' };

  const mailingList = process.argv[2] == 'production'
    ? { env: 'production', id: 'b03de6fc-ff95-40a0-8707-c0706b3c0b31' }
    : { env: 'testing', id: '2bbcdedb-49d8-48f3-9f33-df6e04c9e5bf' };

  const headers = {
    'Authorization': 'Bearer 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',
    'Content-Type': 'application/json',
  };

  // gets current week
  let campaign = null;
  try {
    campaign = require(`./campaigns/${dayjs().format('YYYY')}-${dayjs().week()}.json`);
  } catch (err) {
    console.error(err);
    process.exit(1);
  }

  // gets list subscribers
  const personalizations = [];
  const contacts = await axios.get('https://api.sendgrid.com/v3/marketing/contacts', { headers: headers }).catch(error => { console.log(error) });
  if (contacts) {
    for (const contact of contacts.data.result) {
      if (contact.list_ids.includes(mailingList.id)) {
        personalizations.push({ to: [{ email: contact.email }] });
      }
    }
  }

  // gets handlebars template contents
  let template = null;
  try {
    template = handlebars.compile(fs.readFileSync('template.hbs', 'utf8'));
    template = template(campaign);
  } catch (e) {
    console.error(err);
    process.exit(1);
  }

  // asks for user input to allow sending emails
  console.log(`\nWill send to ${personalizations.length} subscribers from list "${mailingList.env}":`)
  for (const subscriber of personalizations) {
    console.log(' - ', subscriber.to[0].email)
  }

  const consent = await yesno({
    question: '\nAre you sure you want to continue?'
  });

  if (consent) {
    // send actual emails
    await axios.post('https://api.sendgrid.com/v3/mail/send', {
      from,
      subject: `Week #${dayjs().week()} Links`,
      personalizations,
      content: [{
        type: 'text/html',
        value: template
      }]
    }, { headers: headers }).catch(error => { console.log(error) });
  }

  console.log('\nAnd we are done.\n');

}());
