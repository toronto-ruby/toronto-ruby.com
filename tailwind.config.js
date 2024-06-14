const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    colors: {
      beige: '#fff8ef',
      ruby: '#d64045',
      coffee: '#34312d',
      red: colors.red,
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.gray,
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
  ]
}
