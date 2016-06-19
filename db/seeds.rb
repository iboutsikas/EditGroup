# Create Admin
person = Person.create(firstName: "admin", lastName: "admin")

participant  = Participant.create(email: "public@email.com", title: "Mr.", administrative_title: "Lecturer", person_id: person.id)

Member.create(isAdmin: true, person_id: person.id,participant_id: participant.id, bio: "bio", avatar: "", email: "admin@admin.com", password: "asdfasdf", isStudent: false)


# Create Members
# Member 1
person1 = Person.create(firstName: "Geroleonidas", lastName: "Thisisspartamyboneshurt")

participant1  = Participant.create(email: "dkdkss@email.com", title: "Mr.", administrative_title: "Lecturer", person_id: person1.id)

Member.create(isAdmin: false, person_id: person1.id, participant_id: participant1.id, bio: "bio", avatar: "", email: "member1@member1.com", password: "asdfasdf", isStudent: false)

# Member 2
person2 = Person.create(firstName: "Mixalakis", lastName: "Killer")

participant2  = Participant.create(email: "dsdsfdd@email.com", title: "Mr.", administrative_title: "Lecturer", person_id: person2.id)

Member.create(isAdmin: false, person_id: person2.id, participant_id: participant2.id, bio: "bio", avatar: "", email: "member2@member2.com", password: "asdfasdf", isStudent: false)

# Member 3
person3 = Person.create(firstName: "John", lastName: "GeorgiosPapandreou")

participant3  = Participant.create(email: "dkdkss@email.com", title: "DR.", administrative_title: "Professor", person_id: person3.id)

Member.create(isAdmin: false, person_id: person3.id, participant_id: participant3.id, bio: "bio", avatar: "", email: "member3@member3.com", password: "asdfasdf", isStudent: false)

# Student Members
# Student Member 1
person1 = Person.create(firstName: "Mathitoulis", lastName: "Mikros")

participant1  = Participant.create(email: "dkdkss@email.com", title: "Mr.", administrative_title: "Student", person_id: person1.id)

Member.create(isAdmin: false, person_id: person1.id, participant_id: participant1.id, bio: "bio", avatar: "", email: "stumember1@member1.com", password: "asdfasdf", isStudent: true, member_from: Date.today, member_to: Date.today)

# Member 2
person2 = Person.create(firstName: "Trelokostakis", lastName: "Geniousboy")

participant2  = Participant.create(email: "dsdsfdd@email.com", title: "Mr.", administrative_title: "Student", person_id: person2.id)

Member.create(isAdmin: false, person_id: person2.id, participant_id: participant2.id, bio: "bio", avatar: "", email: "stumember2@member2.com", password: "asdfasdf", isStudent: true, member_from: Date.today, member_to: Date.today)

# Member 3
person3 = Person.create(firstName: "Kamilopardali", lastName: "Papadopoulou")

participant3  = Participant.create(email: "dkdkss@email.com", title: "Ms.", administrative_title: "Student", person_id: person3.id)

Member.create(isAdmin: false, person_id: person3.id, participant_id: participant3.id, bio: "bio", avatar: "", email: "stumember3@member3.com", password: "asdfasdf", isStudent: true, member_from: Date.today, member_to: Date.today)

# Create Publications
# Conferences
# Conference 1
conference1 = Publication.create(title: "Conferencopoulos", pages: "3", abstract: "adkkdkdkdkkd", date: Date.today)

Conference.create(name: "trelo conference", publisher: "kapoios", location: "Thessaloniki", publication_id: conference1.id)

	#Authors
author_person1 = Person.create(firstName: "Trelos", lastName: "Authoranthrwpos")
author1 = Author.create(publication_id: conference1.id, person_id: author_person1.id, priority: 10)

author_person2 = Person.create(firstName: "Trelos", lastName: "Authoranthrwpos")
author2 = Author.create(publication_id: conference1.id, person_id: author_person2.id, priority: 10)

author3 = Author.create(publication_id: conference1.id, person_id: person2.id, priority: 10)

conference1.authors << author1
conference1.authors << author2
conference1.authors << author3


# Conference 2
conference2 = Publication.create(title: "Many people that spoke at place good", pages: "3", abstract: "adkkdkdkdkkd", date: Date.today)

Conference.create(name: "don't you conference me", publisher: "yeah", location: "Thessaloniki", publication_id: conference2.id)

	#Authors
author_person1 = Person.create(firstName: "George", lastName: "Michael")
author1 = Author.create(publication_id: conference1.id, person_id: author_person1.id, priority: 10)

author_person2 = Person.create(firstName: "Super", lastName: "Masterguy")
author2 = Author.create(publication_id: conference1.id, person_id: author_person2.id, priority: 10)

author3 = Author.create(publication_id: conference1.id, person_id: person1.id, priority: 10)

conference2.authors << author1
conference2.authors << author2
conference2.authors << author3


# Conference 3
conference3 = Publication.create(title: "Treating sick feet with magic oils and educational things", pages: "3", abstract: "adkkdkdkdkkd", date: Date.today)

Conference.create(name: "Druids Conference", publisher: "kapoios", location: "Forest", publication_id: conference3.id)

	#Authors
author_person1 = Person.create(firstName: "Boula", lastName: "Simiti")
author1 = Author.create(publication_id: conference1.id, person_id: author_person1.id, priority: 10)

author_person2 = Person.create(firstName: "Velo", lastName: "Ciraptor")
author2 = Author.create(publication_id: conference1.id, person_id: author_person2.id, priority: 10)

author3 = Author.create(publication_id: conference1.id, person_id: person2.id, priority: 10)

conference3.authors << author1
conference3.authors << author2
conference3.authors << author3


# Journal 1
journal1 = Publication.create(title: "Dont try to run with feet, try with knowledge", pages: "3", abstract: "adkkdkdkdkkd", date: Date.today)

Journal.create(title: "This is good Journal", volume: 3, issue: 6, publication_id: journal1.id)

	#Authors
author_person1 = Person.create(firstName: "Loukanikos", lastName: "De La Loukan")
author1 = Author.create(publication_id: conference1.id, person_id: author_person1.id, priority: 10)

author_person2 = Person.create(firstName: "Rizoto", lastName: "McJackDaniels")
author2 = Author.create(publication_id: conference1.id, person_id: author_person2.id, priority: 10)

author3 = Author.create(publication_id: conference1.id, person_id: person3.id, priority: 10)

journal1.authors << author1
journal1.authors << author2
journal1.authors << author3


# Journal 2
journal2 = Publication.create(title: "Potatos, and other elements", pages: "3", abstract: "adkkdkdkdkkd", date: Date.today)

Journal.create(title: "Journalicious", volume: 3, issue: 6, publication_id: journal2.id)

	#Authors
author_person1 = Person.create(firstName: "Leonidas", lastName: "Memousia")
author1 = Author.create(publication_id: conference1.id, person_id: author_person1.id, priority: 10)

author_person2 = Person.create(firstName: "Jack", lastName: "Sailormoon")
author2 = Author.create(publication_id: conference1.id, person_id: author_person2.id, priority: 10)

author3 = Author.create(publication_id: conference1.id, person_id: person3.id, priority: 10)

journal2.authors << author1
journal2.authors << author2
journal2.authors << author3


# Journal 3
journal3 = Publication.create(title: "Climb a tree and write article, methodologies and qualifications", pages: "3", abstract: "adkkdkdkdkkd", date: Date.today)

Journal.create(title: "Journal or not you are my son", volume: 3, issue: 6, publication_id: journal3.id)

	#Authors
author_person1 = Person.create(firstName: "Lovely", lastName: "Katsika")
author1 = Author.create(publication_id: conference1.id, person_id: author_person1.id, priority: 10)

author_person2 = Person.create(firstName: "Action", lastName: "Man")
author2 = Author.create(publication_id: conference1.id, person_id: author_person2.id, priority: 10)

author3 = Author.create(publication_id: conference1.id, person_id: person1.id, priority: 10)

journal3.authors << author1
journal3.authors << author2
journal3.authors << author3


# Projects
projects = []
p = Project.create(title: "Projectara", motto: "Die with the rest, project with the best", description: "The project happened with gorgous rithmous with people constantly doing thing and being excelent while achieving project.", date_started: Date.today, website: "www.google.com", video: '<iframe width="560" height="315" src="https://www.youtube.com/embed/Dpl2ZwT4rq0" frameborder="0" allowfullscreen></iframe>')
projects << p
p =  Project.create(title: "This is super project", motto: "To project and to infinity, we become people", description: "Just super, just incredible, all good, no problems", date_started: Date.today, website: "www.google.com", video: '<iframe width="560" height="315" src="https://www.youtube.com/embed/LG-X1iOQBXE" frameborder="0" allowfullscreen></iframe>')
projects << p
p = Project.create(title: "Oh my god", motto: "write a seeder, its good for you", description: "Seedin', seedin', seedin'", date_started: Date.today, website: "www.google.com", video: '<iframe width="560" height="315" src="https://www.youtube.com/embed/GfhOxDvV88I" frameborder="0" allowfullscreen></iframe>')
projects << p
# Project Participations
projects.each do |p|
	part1 = Participation.create(participant_id: participant1.id, project_id: p.id, priority: 10)
	part2 = Participation.create(participant_id: participant2.id, project_id: p.id, priority: 10)
	part3 = Participation.create(participant_id: participant3.id, project_id: p.id, priority: 10)
	p.participations << part1
	p.participations << part2
	p.participations << part3
end


# News Events
NewsEvent.create(date: Date.today, title: "Egina Mitera!", content: "To trixrono tzatziki mou genithike!")

NewsEvent.create(date: Date.today, title: "Crazy Weather", content: "The sun is sunny bad news what an event")

NewsEvent.create(date: Date.today, title: "New Publication by Person", content: "Person publishes Publication")


# Website Templates
# LinkedIn
website_template = WebsiteTemplate.new(website_name: "LinkedIn")
logo_file = File.open('public/websitelogos/linkedin-logo.svg')
website_template.logo = logo_file
website_template.save

# Academia
website_template = WebsiteTemplate.new(website_name: "Academia")
logo_file = File.open('public/websitelogos/academia-logo.svg')
website_template.logo = logo_file
website_template.save

# Google Scholar
website_template = WebsiteTemplate.new(website_name: "Google Scholar")
logo_file = File.open('public/websitelogos/googlescholar-logo.png')
website_template.logo = logo_file
website_template.save

# Research Gate
website_template = WebsiteTemplate.new(website_name: "ResearchGate")
logo_file = File.open('public/websitelogos/researchgate-logo.png')
website_template.logo = logo_file
website_template.save

website_template = WebsiteTemplate.new(website_name: "Personal Website")
logo_file = File.open('public/user.svg')
website_template.logo = logo_file
website_template.save

# Add Personal Websites
Member.all.each do |m|
		WebsiteTemplate.all.each do |t|
			p = PersonalWebsite.new(url: "www.cldldlld.com", website_template: t)
			m.personal_websites << p
		end
end

# Preferences
Preference.create(description: "citation_style", value: "ieee")
Preference.create(description: "publication_display", value: "default")
Preference.create(description: "pagination_publications", value: "5")
Preference.create(description: "pagination_news", value: "10")
Preference.create(description: "pagination_projects", value: "10")
