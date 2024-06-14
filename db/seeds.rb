# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
zone = 'Eastern Time (US & Canada)'
events = [
  {
    name: 'Inaugural Edition',
    location: "Workplace One\n51 Wolseley St, Toronto ON\nLower level, enter through doors on Wolseley St.",
    rsvp_link: nil,
    status: :published,
    presentation: "Integer#even?\nGoing stupidly deep on pointless performance questions, but hopefully learning something fun along the way",
    presenter: 'Matt Eagar',
    sponsor: 'Switch Growth',
    sponsor_logo: 'switch.png',
    sponsor_link: 'https://switchgrowth.com/',
    start_at: ActiveSupport::TimeZone[zone].parse('November 23, 2023 18:00 ET')
  },
  {
    name: 'January Edition',
    location: "Loop Financial\n500-410 Adelaide Street West, Toronto, ON M5V 1S8",
    rsvp_link: nil,
    status: :published,
    presentation: 'Rails and the Ruby Garbage Collector: How to Speed Up Your Rails App',
    presenter: 'Peter Zhu, Senior Developer at Shopify',
    sponsor: 'Loop Financial',
    sponsor_logo: 'loop.png',
    sponsor_link: 'https://bankonloop.com/',
    start_at: ActiveSupport::TimeZone[zone].parse('January 24, 2024 18:00 ET')
  },
  {
    name: 'February Edition',
    location: "Workplace One\n51 Wolseley St, Toronto ON\nLower level, enter through doors on Wolseley St.",
    rsvp_link: nil,
    status: :published,
    presentation: 'All About the Ruby LSP',
    presenter: 'Vinicius Stock, Staff Developer at Shopify',
    sponsor: 'Switch Growth',
    sponsor_logo: 'switch.png',
    sponsor_link: 'https://switchgrowth.com/',
    start_at: ActiveSupport::TimeZone[zone].parse('February 29, 2024 18:00 ET')

  },
  {
    name: 'April Edition',
    location: "FinanceIt @ The Well\n8 Spadina Ave\nSuite 2400\nToronto, ON  M5V 2H6\nPlease note that public access to the building is restricted at 7pm! Please arrive before then.\nWhen you arrive at The Well, please take the high rise elevators (19-38) to the 214th floor to get to reception.",
    rsvp_link: nil,
    status: :published,
    presentation: 'Using Rails introspection to supercharge your editor',
    presenter: 'Andy Waite, Senior Developer at Shopify',
    sponsor: 'Financeit',
    sponsor_logo: 'financeit.png',
    sponsor_link: 'https://www.financeit.io/',
    start_at: ActiveSupport::TimeZone[zone].parse('April 3, 2024 18:00 ET')
  },
  {
    name: 'May Edition',
    location: "Workplace One\n51 Wolseley St, Toronto ON\nLower level, enter through doors on Wolseley St.",
    rsvp_link: 'https://radius.to/groups/toronto-ruby/events/pkgvym5ecyuc',
    status: :published,
    presentation: 'Concurrency in Ruby',
    presenter: 'Raj Kumart, Director of Software Engineering at Stealth',
    sponsor: 'Switch Growth',
    sponsor_logo: 'switch.png',
    sponsor_link: 'https://switchgrowth.com/',
    start_at: ActiveSupport::TimeZone[zone].parse('May 22, 2024 18:00 ET')
  },
  {
    name: 'June Edition',
    location: "Workplace One\n51 Wolseley St, Toronto ON\nLower level, enter through doors on Wolseley St.",
    rsvp_link: 'https://radius.to/groups/toronto-ruby/events/s1tczn2usqf5',
    status: :published,
    presentation: 'Creating A Dev Container Ecosystem For Rails 8',
    presenter: 'Andrew Novoselac, Senior Software Developer at Shopify',
    sponsor: 'Switch Growth',
    sponsor_logo: 'switch.png',
    sponsor_link: 'https://switchgrowth.com/',
    start_at: ActiveSupport::TimeZone[zone].parse('June 20, 2024 18:00 ET')
  }
]

events.each do |event|
  Event.find_or_create_by!(event)
end
