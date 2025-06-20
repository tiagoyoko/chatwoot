module.exports = {
  displayName: 'Testimonials Components',
  testMatch: [
    '<rootDir>/app/javascript/shared/components/testimonials/**/*.spec.js',
  ],
  moduleFileExtensions: ['js', 'vue'],
  transform: {
    '^.+\\.vue$': '@vue/vue3-jest',
    '^.+\\.js$': 'babel-jest',
  },
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/app/javascript/$1',
    '^shared/(.*)$': '<rootDir>/app/javascript/shared/$1',
    '^widget/(.*)$': '<rootDir>/app/javascript/widget/$1',
    '^dashboard/(.*)$': '<rootDir>/app/javascript/dashboard/$1',
  },
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/app/javascript/shared/components/testimonials/test-setup.js'],
  collectCoverageFrom: [
    'app/javascript/shared/components/testimonials/**/*.{js,vue}',
    '!app/javascript/shared/components/testimonials/**/*.spec.js',
    '!app/javascript/shared/components/testimonials/TestimonialsDemo.vue',
    '!app/javascript/shared/components/testimonials/index.js',
  ],
  coverageReporters: ['text', 'lcov', 'html'],
  coverageDirectory: '<rootDir>/coverage/testimonials',
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
};

