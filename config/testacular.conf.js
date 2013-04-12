basePath = '../';

files = [
  JASMINE,
  JASMINE_ADAPTER,

  // Angular code
  'components/angular/angular.js',
  // Do not glob like angular-*/angular-*.js here to not include angular-scenario,
  // which has its own, conflicting test runner.
  'components/angular-mocks/angular-mocks.js',
  'components/angular-resource/angular-resource.js',

  // Other library code

  // Our code
  'build/app/**/*.js',
  'build/test/unit/**/*.js'
];

autoWatch = true;

browsers = ['Chrome'];

junitReporter = {
  outputFile: 'test_out/unit.xml',
  suite: 'unit'
};
