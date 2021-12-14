module.exports = {
  mode: 'jit',
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      fontFamily: {
        titan: ["Titan One", "cursive"]
      }
    }
  },
  variants: {},
  plugins: [
    require('@tailwindcss/forms')
  ]
};
