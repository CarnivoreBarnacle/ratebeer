# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

br1 = Brewery.create name:"Koff", year:1897
br2 = Brewery.create name:"Malmgard", year:2001
br3 = Brewery.create name:"Weihenstephaner", year:1042

s0 = Style.create name:"Default", description: "Default"
s1 = Style.create name:"Euro Pale Lager", description: "Similar to the Munich Helles story, many European countries reacted to the popularity of early pale lagers by brewing their own. Hop flavor is significant and of noble varieties, bitterness is moderate, and both are backed by a solid malt body and sweetish notes from an all-malt base."
s2 = Style.create name:"English India Pale Ale (IPA)", description: "First brewed in England and exported for the British troops in India during the late 1700s. To withstand the voyage, IPA's were basically tweaked Pale Ales that were, in comparison, much more malty, boasted a higher alcohol content and were well-hopped, as hops are a natural preservative. Historians believe that an IPA was then watered down for the troops, while officers and the elite would savor the beer at full strength. The English IPA has a lower alcohol due to taxation over the decades. The leaner the brew the less amount of malt there is and less need for a strong hop presence which would easily put the brew out of balance. Some brewers have tried to recreate the origianl IPA with strengths close to 8-9% abv."


b1 = br1.beers.create name:"Iso 3"
b2 = br1.beers.create name:"Karhu"
b3 = br1.beers.create name:"Tuplahumala"
b4 = br2.beers.create name:"Huvila Pale Ale"
b5 = br2.beers.create name:"X Porter"
b6 = br3.beers.create name:"Hefeweizen"
b7 = br3.beers.create name:"Helles"

b1.style = s0
b2.style = s0
b3.style = s0
b4.style = s0
b5.style = s0
b6.style = s0
b7.style = s0

b1.save
b2.save
b3.save
b4.save
b5.save
b6.save
b7.save
