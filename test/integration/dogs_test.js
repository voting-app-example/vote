Feature('Dogs');

Scenario('Verify dogs voting option is shown', ({ I }) => {
  I.amOnPage('/');
  I.see('BIRDS');
});