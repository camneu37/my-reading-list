cam = User.create(name: "Camille", username: "camille", password: "camille")
car = User.create(name: "Carole", username: "carole", password: "carole")


mich = Author.create(name: "Michael Lewis")
tom = Author.create(name: "Tom Wolfe")
hunter = Author.create(name: "Hunter S. Thompson")



big = Book.create(title: "The Big Short: Inside the Doomsday Machine", summary: "About the buildup of the US housing bubble during the 2000s", author_id: mich.id, creator_id: cam.id)
liars = Book.create(title: "Liar's Poker: Rising through the Wreckage on Wall Street", summary: "Experiences as a bond salesman on Wall Street in the 1980s", author_id: mich.id, creator_id: cam.id)
flash = Book.create(title: "Flash Boys: A Wall Street Revolt", summary: "Investigation into the phenomenon of high-frequency trading (HFT) in the US equity market.", author_id: mich.id, creator_id: cam.id)
bonfire = Book.create(title: "The Bonfire of the Vanities", summary: "A satirical drama about ambition, racism, social class, politics, and greed in 1980s New York City", author_id: tom.id, creator_id: cam.id)
electric = Book.create(title: "The Electric Kool-Aid Acid Test", summary: "An account of the experiences of Ken Kesey and his band of merry pranksters.", author_id: tom.id, creator_id: cam.id)
fear = Book.create(title: "Fear and Loathing in Las Vegas", summary: "A savage journey to the heart of the American Dream", author_id: hunter.id, creator_id: cam.id)
rum = Book.create(title: "The Rum Diary", summary: "American journalist in 1960s Peurto Rico struggles to find balance between island culture and the expatriates who live there.", author_id: hunter.id, creator_id: cam.id)
