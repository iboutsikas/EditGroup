# Create Admin
person = Person.create(firstName: "Athanasios", lastName: "Hatziapostolou")

participant  = Participant.create(email: "member1@edit.com", title: "Mr.", administrative_title: "Senior Lecturer, CS Department", person_id: person.id)

hatzis = Member.create(isAdmin: true, person_id: person.id,participant_id: participant.id, bio: "Mr. Hatziapostolou is the coordinator of the Educational Informatics research group. He has been concerned with the development, evaluation and deployment of innovative teaching-learning technologies and methods for higher education in blended and distance learning settings. His primary interests also include intelligent and personalised learning management systems, computer science education, and entrepreneurial education. Mr. Hatziapostolou is also the academic supervisor of the College's learning management system.", avatar: "", email: "member1@edit.com", password: "asdfasdf", isStudent: false)

# Create Members
# Member 1
person1 = Person.create(firstName: "Iraklis", lastName: "Paraskakis")

participant1  = Participant.create(email: "member2@edit.com", title: "Dr.", administrative_title: "Senior Lecturer, CS Department", person_id: person1.id)

paras = Member.create(isAdmin: false, person_id: person1.id, participant_id: participant1.id, bio: "Dr. Paraskakis' interests are in the area of Education and Information Technology and in particular the formalisation of multiple teaching strategies. Other areas of research include the use of virtual learning management systems and mobile learning. He has worked as an Associate Lecturer at the Open University (UK) and as a part-time Lecturer at Bedford College and Stevenage College. Currently he is also an Associate Lecturer with the Hellenic Open University in the Department of Informatics.", avatar: "", email: "member2@edit.com", password: "StupidP@ssw0rd", isStudent: false)

# Member 2
person2 = Person.create(firstName: "Anna", lastName: "Sotiriadou")

participant2  = Participant.create(email: "member3@edit.com", title: "Mrs.", administrative_title: "Head of Computer Science Department", person_id: person2.id)

sotir = Member.create(isAdmin: false, person_id: person2.id, participant_id: participant2.id, bio: "Mrs. Sotiriadou is the Head and Senior Lecturer of the Computer Science Department. She is a member of the organising and scientific committees in a number of scientific conferences, she has published in various conferences and edited books. She has also taught Probability and Statistics courses in the Statistics Department of the University of Rochester. Her research interests are centered around Computer Science education, teaching and learning in higher education and formal methods in software engineering.", avatar: "", email: "member3@edit.com", password: "12345678", isStudent: false)

# Member 3
person3 = Person.create(firstName: "Petros", lastName: "Kefalas")

participant3  = Participant.create(email: "member4@edit.com", title: "Dr.", administrative_title: "Vice-Principal", person_id: person3.id)

kefal = Member.create(isAdmin: false, person_id: person3.id, participant_id: participant3.id, bio: "Dr. Kefalas research interests are centred around Artificial Intelligence and the applicability of formal methods for specifying, verifying and testing agent systems. He has published around 80 papers in journal and conference proceedings and co-authored a Greek textbook. As the Director for Teaching and Learning of CITY College, his research also includes quality assurance in higher education, intelligent learning management systems, innovative teaching/learning methods and computer science education.", avatar: "", email: "member4@edit.com", password: "ExMachinaRocks123", isStudent: false)

# Member 4
person4 = Person.create(firstName: "Dimitris", lastName: "Dranidis")

participant4  = Participant.create(email: "member5@edit.com", title: "Dr.", administrative_title: "Academic Director of MSc in Software Engineering and Telecommunications", person_id: person4.id)

dran = Member.create(isAdmin: false, person_id: person4.id, participant_id: participant4.id, bio: "Dr Dranidis's interests are in the areas of Software Engineering, Formal methods, and Artificial Intelligence. He is involved in investigating software development methodologies for service-oriented architecture, object-oriented technologies, and agile formal methods. Dr. Dranidis research interests also include software engineering education, web 2.0 in education, web services for education systems, computer science education, project-based learning, vocational education and training, and lifelong learning.", avatar: "", email: "member5@edit.com", password: "JsxmJsxm", isStudent: false)

# Student Members
# Student Member 1
person5 = Person.create(firstName: "Petros", lastName: "Lameras")

participant5  = Participant.create(email: "member6@edit.com", title: "Mr.", administrative_title: "PhD Candidate", person_id: person5.id)

lama = Member.create(isAdmin: false, person_id: person5.id,
participant_id: participant5.id, bio: "Mr. Lameras PhD research project is related with issues concerning social and educational informatics and has provided him with the opportunity to engage deeply with the complexities of e-learning in SEE countries and to contribute to the ongoing development of e-learning and the wider field of educational informatics. His research interests include blended learning, distance learning,
computer assisted learning, learning organizations, virtual universities, virtual learning environments with computer mediated communications.", avatar: "",
email: "member6@edit.com", password: "asdfasdf", isStudent: true, member_from: Date.today, member_to: Date.today)

# Create Publications
# Conferences
conference1 = Publication.create(title:"Engage with InGauge: Measuring Participation and Engagement within an Academic Facebook Group",
 pages: "3", abstract: "Abstractly", date: Date.parse("May-2015"))

Conference.create(name: "7th International Conference on Computer Supported Education",
location: "Lisbon, Portugal", publication_id: conference1.id)

#Authors
author_person1 = person
author1 = Author.create(publication_id: conference1.id, person_id: author_person1.id, priority: 1)

author_person2 = Person.create(firstName: "Gellci", lastName: "J.")
author2 = Author.create(publication_id: conference1.id, person_id: author_person2.id, priority: 2)

author3 = Author.create(publication_id: conference1.id, person_id: person1.id, priority: 3)

conference1.authors << author1
conference1.authors << author2
conference1.authors << author3

#Conference 2
conference2 = Publication.create(title:"Boosting the Pedagogical Value of Classroom Clickers via a provision of formative feedback",
 pages: "10", abstract: "Null", date: Date.parse("July-2014"))

Conference.create(name: "14th IEEE Int. Conference on Advanced Learning Technologies",
location: "Athens, Greece", publication_id: conference2.id)

#Authors
author1 = Author.create(publication_id: conference2.id, person_id: person.id, priority: 1)

author_person2 = Person.create(firstName: "Pupovci", lastName: "T")
author2 = Author.create(publication_id: conference2.id, person_id: author_person2.id, priority: 2)

author3 = Author.create(publication_id: conference2.id, person_id: person1.id, priority: 3)

author_person3 = Person.create(firstName: "Marina", lastName: "Ntika")
author4 = Author.create(publication_id: conference2.id, person_id: author_person3.id, priority: 4)

conference2.authors << author1
conference2.authors << author2
conference2.authors << author3
conference2.authors << author4

#Conference 3
conference3 = Publication.create(title:"Facebook as an Informal Learning Platform",
 pages: "69", abstract: "Null", date: Date.parse("July-2014"))

Conference.create(name: "6th International Conference on Education and new Learning Technologies",
location: "Barcelona, Spain", publication_id: conference3.id)

#Authors
author_person1 = Person.create(firstName: "E", lastName: "Mustafa")
author1 = Author.create(publication_id: conference3.id, person_id: author_person1.id, priority: 2)

author_person2 = Person.create(firstName: "T", lastName: "Pupovci")
author2 = Author.create(publication_id: conference3.id, person_id: author_person2.id, priority: 1)

author_person3 = Person.create(firstName: "V", lastName: "Kastrati")
author3 = Author.create(publication_id: conference3.id, person_id: author_person3.id, priority: 3)

author4 = Author.create(publication_id: conference3.id, person_id: person.id, priority: 5)

author_person4 = Person.create(firstName: "B", lastName: "Nalbani")
author5 = Author.create(publication_id: conference3.id, person_id: author_person4.id, priority: 4)

conference3.authors << author1
conference3.authors << author2
conference3.authors << author3
conference3.authors << author4

#___________________________Auta pou evala  egw, Panos_____________________________________________
conference4 = Publication.create(title:"Re-KAP: The Next 'Click' in Classroom Clicker Systems",
	pages:"66",abstract:"Abstractly", date: Date.parse("June-2014"))

Conference.create(name: "World Conference on Educational Media and Technology",
location: "Tampere, Finland", publication_id: conference4.id)

author1 = Author.create(publication_id: conference4.id, person_id: person.id, priority: 1)
author_person = Person.create(firstName: "T", lastName: "Pupovci")
author2 = Author.create(publication_id: conference4.id, person_id: author_person.id, priority: 2)
author3 = Author.create(publication_id: conference4.id, person_id: person1.id, priority: 4)
author4 = Author.create(publication_id: conference4.id, person_id: person4.id, priority: 3)

conference4.authors << author1
conference4.authors << author2
conference4.authors << author3
conference4.authors << author4

#authors: Hatziapostolou, T., Pupovci, T., Dranidis, D., Paraskakis, I.
#______________________________________________________________________________________
conference5 = Publication.create(title:"Cloud e-Learning: A New Challenge for Multi-Agent Systems",
	pages:"66",abstract:"Abstractly", date: Date.parse("June-2014"))

Conference.create(name: "8th International KES Conference on Agents and Multi-agent Systems - Technologies and Applications",
location: "Chania, Greece", publication_id: conference5.id)

author1 = Author.create(publication_id: conference5.id, person_id: person.id, priority: 4)
author_person = Person.create(firstName: "K", lastName: "Pireva")
author2 = Author.create(publication_id: conference5.id, person_id: author_person.id, priority: 1)
author_person1 = Person.create(firstName: "T", lastName: "Cowling")
author3 = Author.create(publication_id: conference5.id, person_id: author_person1.id, priority: 5)
author4 = Author.create(publication_id: conference5.id, person_id: person4.id, priority: 3)
author5 = Author.create(publication_id: conference5.id, person_id: person3.id, priority: 3)
conference5.authors << author5
conference5.authors << author4
conference5.authors << author3
conference5.authors << author2
conference5.authors << author1
#authors: Pireva, K., Kefalas, P., Dranidis, D., Hatziapostolou, T., Cowling, T.

#______________________________________________________________________________________
conference6 = Publication.create(title:"The Elevate Framework for Assessment and Certification Design for Vocational Training in European ICT SMEs",
	pages:"66",abstract:"Abstractly", date: Date.parse("April-2014"))

Conference.create(name: "6th International Conference on Computer Supported Education",
location: "Barcelona, Spain", publication_id: conference6.id)

author1 = Author.create(publication_id: conference6.id, person_id: person.id, priority: 2)
author2 = Author.create(publication_id: conference6.id, person_id: person1.id, priority: 1)
conference6.authors << author1
conference6.authors << author2
#authors: Paraskakis, I., Hatziapostolou, T.




# Projects
Project.create(title: "EMBED4AUTO", motto: "Auto moto triti", description: "The goal of this project is to providing the European industry with innovative training for model-based development technologies and help to promote the use of model-based technologies in the area of embedded systems development Funded by the Leonardo Da Vinci Programme.", date_started: Date.today, video: '<iframe width="420" height="315" src="https://www.youtube.com/embed/wZZ7oFKsKzY" frameborder="0" allowfullscreen></iframe>')

Project.create(title: "QF EMBODIMENT", motto: "United we stand, divided we fall",
description: "This project analyses in the context of vocational tranining the development of national and sectoral qualifications frameworks of participating countries as well as the establishment of the qualifications frameworks of eight selected sectors contained in the work plan and their convergence thereof to the European Qualification Framework. Funded by the Leonardo Da Vinci Programme.", date_started: Date.today)

Project.create(title: "ELEVATE", motto: "Write a seeder, Its good for you",
description: "The main aim of this project is the integration of pedagogically-documented, value-added e-training add ons in commercial software products of European Software SMEs (funded by FP7, Research for the Benefit of SMEs programme.", date_started: Date.today, video: '<iframe width="560" height="315" src="https://www.youtube.com/embed/vGfTLb6RFk0" frameborder="0" allowfullscreen></iframe>')

Project.create(title: "ORGANIK", motto: "Only MEAT and GMO's",
description: "This project focuses in an organic knowledge management system for small European knowledge-intensive companies (funded by FP7, Research for the Benefit of SMEs programme).", date_started: Date.today, video: '<iframe width="420" height="315" src="https://www.youtube.com/embed/D2IcKgXhagM" frameborder="0" allowfullscreen></iframe>')

Project.create(title: "EMBEDDING STANDARDS", motto: "High Standards",
description: "Embedding ICT/Multimedia Standardisation Initiatives into European Vocational Training Development Strategies, funded by the Leonardo Da Vinci Programme, DG Education and Training. Click here for more information.", date_started: Date.today, video: '<iframe width="420" height="315" src="https://www.youtube.com/embed/MW_MTHCJkKg" frameborder="0" allowfullscreen></iframe>')

Project.create(title: "AMBIENT LEARNING", motto: "Got Nothin'",
description: "The objective of the project is to provide a pragmatic, easy-to-use eLearning service, which allows any time, any where and any how access to personalised, high quality learning content. The ambient learning service offers ambient, multimodal, personalised and context-sensitive access to learning at work, at home, at a training institution or on the move. (FP6- eTen).", date_started: Date.today)

# News Events
NewsEvent.create(date: Date.parse("20/03/2008"), title: "Dr. Iraklis Paraskakis was a keynote speaker",
content: "Dr. Iraklis Paraskakis was a keynote speaker in the 5th International Conference on Informatics, Educational Technology and New Media in Education, Sombor, Serbia. Click here for more information.")

NewsEvent.create(date: Date.parse("25/10/2007"), title: "They Gave a seminar!!!",
content: "At CITY College's annual Staff Development Workshop, Mr. Hatziapostolou and Dr. Kefalas gave a seminar in Advanced Uses of Claroline Learning Management System.")

NewsEvent.create(date: Date.parse("29/11/2007"), title: "See content",
content: "The Computer Science Department of CITY College and the South-East European Research Centre organized the Second Informatics Education Europe Conference (IEEII) in Thessaloniki Greece. The was conference was mainly sponsored by ACM through its Education Board.")

NewsEvent.create(date: Date.parse("18/09/2006"), title: "See content again",
content: "	At CITY College's annual Staff Development Workshop, Mr. Hatziapostolou discussed research and industrial informed teaching, Dr. Dranidis discussed methods of involving the industry in the education provision, and Mrs. Sotiriadou discussed types of assessment and the importance of feedback")

NewsEvent.create(date: Date.parse("08/06/2006"), title: "Someone downloaded Dr. Paskakis' paper!",
content: "Dr. Iraklis Paraskakis paper Ambient Learning: a New Paradigm for e-learning was the most downloaded paper of the of the 3rd International Conference on Multimedia and Information & Communication Technologies in Education, June 8-10th 2005, Caceres, Spain.")


# Website Templates
# LinkedIn
website_templateL = WebsiteTemplate.new(website_name: "LinkedIn")
logo_file = File.open('public/websitelogos/linkedin-logo.svg')
website_templateL.logo = logo_file
website_templateL.save

# Academia
website_templateA = WebsiteTemplate.new(website_name: "Academia")
logo_file = File.open('public/websitelogos/academia-logo.svg')
website_templateA.logo = logo_file
website_templateA.save

# Google Scholar
website_templateGS = WebsiteTemplate.new(website_name: "Google Scholar")
logo_file = File.open('public/websitelogos/googlescholar-logo.png')
website_templateGS.logo = logo_file
website_templateGS.save

# Research Gate
website_templateRG = WebsiteTemplate.new(website_name: "ResearchGate")
logo_file = File.open('public/websitelogos/researchgate-logo.png')
website_templateRG.logo = logo_file
website_templateRG.save

#Personal Website
website_templatePW = WebsiteTemplate.new(website_name: "Personal Website")
logo_file = File.open('public/user.svg')
website_templatePW.logo = logo_file
website_templatePW.save

hatzis.personal_websites << PersonalWebsite.new(url: "https://linkedin.com/in/thanoshatziapostolou",website_template: website_templateL)
hatzis.personal_websites << PersonalWebsite.new(url: "https://academic.academia.edu/ThanosHatziapostolou",website_template: website_templateA)
hatzis.personal_websites << PersonalWebsite.new(url: "https://www.researchgate.net/profile/Thanos_Hatziapostolou",website_template: website_templateRG)

paras.personal_websites << PersonalWebsite.new(url:"https://linkedin.com/in/paraskakis", website_template: website_templateL)
paras.personal_websites << PersonalWebsite.new(url:"https://sheffield.academia.edu/IraklisParaskakis", website_template: website_templateA)
paras.personal_websites << PersonalWebsite.new(url: "https://www.researchgate.net/profile/Iraklis_Paraskakis",website_template: website_templateRG)
paras.personal_websites << PersonalWebsite.new(url: "https://scholar.google.gr/citations?user=bz8kBogAAAAJ&hl=en",website_template: website_templateGS)

sotir.personal_websites << PersonalWebsite.new(url: "https://linkedin.com/in/anna-sotiriadou-2945291", website_template: website_templateL)
sotir.personal_websites << PersonalWebsite.new(url: "https://www.researchgate.net/profile/Anna_Sotiriadou2",website_template: website_templateRG)

kefal.personal_websites << PersonalWebsite.new(url: "https://linkedin.com/in/petros-kefalas-4725261", website_template: website_templateL)
kefal.personal_websites << PersonalWebsite.new(url: "https://academic.academia.edu/PetrosKefalas", website_template: website_templateA)
kefal.personal_websites << PersonalWebsite.new(url: "https://www.researchgate.net/profile/Petros_Kefalas",website_template: website_templateRG)
kefal.personal_websites << PersonalWebsite.new(url: "https://scholar.google.gr/citations?user=ZDag7r0AAAAJ&hl=en&oi=ao",website_template: website_templateGS)

dran.personal_websites << PersonalWebsite.new(url:"https://linkedin.com/in/dranidis", website_template: website_templateL)
dran.personal_websites << PersonalWebsite.new(url:"https://academic.academia.edu/DimitrisDranidis", website_template: website_templateA)
dran.personal_websites << PersonalWebsite.new(url: "https://www.researchgate.net/profile/Dimitris_Dranidis",website_template: website_templateRG)

lama.personal_websites << PersonalWebsite.new(url: "https://scholar.google.gr/citations?user=pcf2dY0AAAAJ&hl=en",website_template: website_templateGS)

# Preferences
Preference.create(description: "citation_style", value: "ieee")
Preference.create(description: "publication_display", value: "default")
Preference.create(description: "pagination_publications", value: "5")
Preference.create(description: "pagination_news", value: "10")
Preference.create(description: "pagination_projects", value: "10")
