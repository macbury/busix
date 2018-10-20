module.exports = {
  clearMocks: true,
  coverageDirectory: 'coverage',
  globals: {
    'ts-jest': {
      tsConfig: 'tsconfig.json',
    },
  },
  moduleFileExtensions: [
    'js',
    'ts',
    'tsx',
  ],
  testMatch: [
    '**/test/**/?(*.)+(spec|test).(ts|tsx|js)',
  ],
  transform: {
    '^.+\\.(ts|tsx)$': 'ts-jest',
  },
  preset: 'ts-jest',
}
