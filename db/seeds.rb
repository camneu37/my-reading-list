clar = Author.new(name: "Clarice Lispector")
geo = Author.new(name: "Geoff Dyer")
mich = Author.new(name: "Michael Lewis")
jas = Author.new(name: "Jasmin Darznik")


chand = Book.new(title: "The Chandelier", author_id: clar.id)
street = Book.new(title: "The Street Philosophy of Garry Winogrand", author_id: geo.id)
big = Book.new(title: "The Big Short", author_id: mich.id)
liars = Book.new(title: "Liar's Poker", author_id: mich.id)
song = Book.new(title: "Song of a Captive Bird", author_id: jas.id)
