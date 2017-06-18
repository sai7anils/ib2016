namespace :data do
  desc 'Create sample data'
  task sample: :environment do
    user_sample
  end

  def user_sample
    puts 'Deleting old users...'
    User.where.not(user_type: 1).destroy_all

    puts 'Creating users...'
    10.times do |index|
      user1 = User.create!({
        username: "entrepreneur#{index}",
        user_type: :entrepreneur,
        email: "entrepreneur#{index}@ideaburns.com",
        password: '12345678',
        country: 'US',
        city: 'Alaska',
        region: 'AK',
        photo: Rails.root.join('app/assets/images/entrepreneur.png').open,
        confirmed_at: Time.now
        })
      user1.entrepreneur = Entrepreneur.new({
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name
        })
      5.times do
        idea = user1.ideas.build({
          title: Faker::Lorem.sentence,
          category_id: Category.all.sample.id,
          description: Faker::Lorem.paragraph(50),
          views: Faker::Number.number(2),
          idea_type: [true, false].sample
          })
        idea.save
      end

      5.times do
        idea = user1.ideas.build({
          title: Faker::Lorem.sentence,
          category_id: Category.all.sample.id,
          description: Faker::Lorem.paragraph(4, true, 5),
          views: Faker::Number.number(2),
          idea_type: false
        })
        idea.build_business_idea
        idea.business_idea.build_market_analysis
        idea.business_idea.build_team_cappabilitie
        idea.business_idea.build_customer_analysis
        idea.business_idea.build_investment_scale
        idea.business_idea.build_business_potencial
        idea.business_idea.build_exit_strategie
        idea.business_idea.build_pitch_burn
        idea.business_idea.pitch_burn.attachments.build
        idea.business_idea.build_competitor
        idea.business_idea.business_potencial.build_per_unit

        idea.business_idea = BusinessIdea.new({
          business_line: Faker::Number.between(1, 20),
          tagline: Faker::Lorem.sentence,
          problem_statement: Faker::Lorem.paragraph(4, true, 5),
          solution: Faker::Lorem.paragraph(4, true, 5),
          idea_stage: Faker::Number.between(5, 9)*10,
          ip_patent: "100",
          motivation_vision: Faker::Number.between(1, 5),
          year_exp: Faker::Number.between(1, 3),
          startup_business: Faker::Number.between(1, 5),
          business_model: Faker::Number.between(1, 5),
          des_business_model: Faker::Lorem.paragraph(4, true, 5),
          idea_execution: Faker::Lorem.paragraph(4, true, 5),
          business_idea_type: Faker::Number.between(1, 3),
          register_number: "100"
        })
        idea.business_idea.market_analysis = MarketAnalysis.new({
          is_new: [true, false].sample,
          have_major: [true, false].sample,
          market_size: Faker::Number.between(1, 5),
          market_analyses_des: Faker::Lorem.paragraph(4, true, 5),
          market_trend: Faker::Number.between(1, 5),
          market_channels: Faker::Number.between(1, 5)
        })
        idea.business_idea.customer_analysis = CustomerAnalysis.new({
          idea_solve: Faker::Lorem.paragraph(4, true, 5),
          big_customer: Faker::Number.between(1, 5),
          about: Faker::Lorem.paragraph(4, true, 5),
          from_age: Faker::Time.backward(365, :evening),
          to_age: Faker::Time.forward(365, :morning),
          steps: Faker::Lorem.paragraph(4, true, 5),
          region: ["us_AL", "us_CA", "us_KY"]
        })
        idea.business_idea.investment_scale = InvestmentScale.new({
          total_capital: Faker::Number.between(1, 10),
          fund_already: Faker::Number.between(0, 7)*10,
          fund_like_to_invest: Faker::Number.between(0, 7)*10,
          fund_you_seeking: Faker::Number.between(1, 10),
          offering_business: Faker::Number.between(10, 90),
          use_fund: Faker::Lorem.paragraph(4, true, 5)
        })
        idea.business_idea.pitch_burn = PitchBurn.new({
          your_own: Rails.root.join('app/assets/images/entrepreneur.png').open,
          your_idea_legally: Faker::Lorem.paragraph(4, true, 5)
        })
        idea.business_idea.pitch_burn.attachments.build(file: Faker::Avatar.image)

        idea.business_idea.exit_strategie = ExitStrategie.new({business_exit_strategy: Faker::Lorem.paragraph(4, true, 5)})
        idea.business_idea.team_cappabilitie = TeamCappabilitie.new({
          crucial_skills: Faker::Number.between(1, 5),
          strength: Faker::Number.between(0, 20),
          team_attributes: Faker::Number.between(1, 5)
        })
        idea.business_idea.team_cappabilitie.business_teams.build(
          name: Faker::Superhero.name,
          role: Faker::Lorem.sentence,
          skills: Faker::Lorem.sentence,
          joined: Faker::Number.between(1, 3),
          profile_image: Faker::Avatar.image
        )
        idea.business_idea.business_potencial = BusinessPotencial.new({
          projection_type: Faker::Number.between(1, 2),
          term_number: "3",
          revenue_type: Faker::Number.between(1, 4)
        })

        idea.business_idea.competitor = Competitor.new({
          about: Faker::Lorem.paragraph(4, true, 5),
          image: Faker::Avatar.image
        })
        idea.business_idea.competitor.competitor_teams.build(
          name: Faker::Superhero.name ,
          business_line: Faker::Lorem.sentence,
          country: "AZ",
          revenue: Faker::Lorem.sentence,
          website: "ideaburn-goldenowl.herokuapp.com",
        )
        per_unit = PerUnit.new({
          sale: ActiveSupport::JSON.decode("{\"1\":0,\"2\":0,\"3\":0,\"4\":0,\"5\":0,\"6\":12,\"7\":2,\"8\":0,\"9\":2,\"10\":3,\"11\":1,\"12\":2}"),
          price: ActiveSupport::JSON.decode("{\"1\":0,\"2\":0,\"3\":0,\"4\":0,\"5\":0,\"6\":2,\"7\":3,\"8\":1,\"9\":2,\"10\":9,\"11\":5,\"12\":1}")
        })
        idea.business_idea.business_potencial.per_unit = per_unit
        idea.save
      end

      5.times do
        event = user1.events.build({
            title: Faker::Lorem.sentence,
            entry_type: Faker::Number.between(1, 2),
            paid_entry_cost_min: Faker::Number.between(1, 2),
            website: "google.com",
            event_image: Faker::Avatar.image,
            timezone: Faker::Address.time_zone,
            event_from: Faker::Date.between(5.days.ago, Date.today),
            event_to: Faker::Date.between(2.days.ago, Date.today),
            event_time: Faker::Date.between(2.days.ago, Date.today).strftime("%m:%M %p ") ,
            views: Faker::Number.number(2),
            address_line_1: Faker::Address.street_address,
            city: Faker::Address.city,
            country: Faker::Address.country_code,
            region: Faker::Address.city,
            zipcode: Faker::Address.zip_code
          })
        event.save
      end

      5.times do
        event = user1.events.build({
            title: Faker::Lorem.sentence,
            entry_type: Faker::Number.between(1, 2),
            paid_entry_cost_min: Faker::Number.between(1, 2),
            website: "google.com",
            event_image: Faker::Avatar.image,
            timezone: Faker::Address.time_zone,
            event_from: Faker::Time.forward(23),
            event_to: Faker::Time.forward(25),
            event_time: Faker::Time.forward(24),
            views: Faker::Number.number(2),
            address_line_1: Faker::Address.street_address,
            city: Faker::Address.city,
            country: Faker::Address.country_code,
            region: Faker::Address.city,
            zipcode: Faker::Address.zip_code
          })
        event.save
      end

      user2 = User.create!({
        username: "startup#{index}",
        user_type: :startup,
        email: "startup#{index}@ideaburns.com",
        password: '12345678',
        country: 'US',
        city: 'Alaska',
        region: 'AK',
        photo: Rails.root.join('app/assets/images/startup.png').open,
        confirmed_at: Time.now
        })
      user2.startup = Startup.new({
        name: Faker::Name.name
        })

      user3 = User.create!({
        username: "investor#{index}",
        user_type: :investor,
        email: "investor#{index}@ideaburns.com",
        password: '12345678',
        country: 'US',
        city: 'Alaska',
        region: 'AK',
        photo: Rails.root.join('app/assets/images/investor.jpg').open,
        confirmed_at: Time.now
        })
      user3.investor = Investor.new({
        name: Faker::Name.name
        })

      puts "#{(index + 1)*10}%..."
    end

    User.update_all("slug":nil)
    User.find_each(&:save)

    puts 'Done! Created sample users'
  end
end