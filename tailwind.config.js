module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    colors: {
      'beige': '#fff8ef',
      'ruby': '#d64045',
      'coffee': '#34312d'
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
  ]
}
