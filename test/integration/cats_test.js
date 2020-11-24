Feature('Cats');

Scenario('Verify cats voting option is shown', ({ I }) => {
  I.amOnPage('/');
  I.see('CATS');
});