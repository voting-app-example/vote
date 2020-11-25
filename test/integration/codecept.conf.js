exports.config = {
  tests: './*_test.js',
  output: './output',
  helpers: {
    Playwright: {
      url: 'http://localhost',
      show: false,
    }
  },
  bootstrap: null,
  mocha: {
    reporterOptions: {
      reportDir: "./output"
    }
  },
  include: {},
  name: 'integration',
  plugins: {
    pauseOnFail: {},
    retryFailedStep: {
      enabled: true
    },
    tryTo: {
      enabled: true
    },
    screenshotOnFail: {
      enabled: true
    }
  }
}