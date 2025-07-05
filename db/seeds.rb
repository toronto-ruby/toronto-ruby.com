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
sponsors = [
  {
    name: 'Switch',
    logo: 'switch.png',
    link: 'https://switchgrowth.com'
  },
  {
    name: 'Shopify',
    logo: 'shopify.png',
    link: 'https://shopify.com'
  },
  {
    name: 'Clio',
    logo: 'clio.png',
    link: 'https://clio.com'
  }
]

15.times do
  sponsor = sponsors.sample
  before_after = rand(10) > 5
  now = Time.now.utc
  time = before_after ? now + rand(7).days : now - rand(7).days
  Event.create(
    name: SecureRandom.hex(8),
    location: "Location #{SecureRandom.hex(8)}",
    description: "Description #{SecureRandom.hex(8)}",
    sponsor: sponsor[:name],
    sponsor_logo: sponsor[:logo],
    sponsor_link: sponsor[:link],
    status: :published,
    start_at: time
  )
end

events = [
  {
    name: 'Inaugural Edition',
    location: "Workplace One\n51 Wolseley St, Toronto ON\nLower level, enter through doors on Wolseley St.",
    rsvp_link: nil,
    status: :published,
    description: "Integer#even?\nGoing stupidly deep on pointless performance questions, but hopefully learning something fun along the way\nby Matt Eagar",
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
    description: 'Rails and the Ruby Garbage Collector: How to Speed Up Your Rails App by Peter Zhu, Senior Developer at Shopify',
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
    description: 'All About the Ruby LSP by Vinicius Stock, Staff Developer at Shopify',
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
    description: 'Using Rails introspection to supercharge your editor by Andy Waite, Senior Developer at Shopify',
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
    description: 'Concurrency in Ruby by Raj Kumart, Director of Software Engineering at Stealth',
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
    description: 'Creating A Dev Container Ecosystem For Rails 8 by Andrew Novoselac, Senior Software Developer at Shopify',
    sponsor: 'Switch Growth',
    sponsor_logo: 'switch.png',
    sponsor_link: 'https://switchgrowth.com/',
    start_at: ActiveSupport::TimeZone[zone].parse('June 20, 2024 18:00 ET')
  }
]

events.each do |event|
  e = Event.find_or_initialize_by(event.except(:location, :description))
  e.location = event[:location]
  e.description = event[:description]
  e.save!
end
