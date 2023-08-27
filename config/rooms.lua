---@enum eRooms
local eRooms = {
    "Foyer",
    "Library",
    "Parlor",
    "Smoking Room",
    "Music Room",
    "Banquet Hall"
}

---@enum eDir
local eDir = {
    u = "u",
    d = "d",
    l = "l",
    r = "r"
}
---@class rooms
local rooms = {
    names = eRooms,
    directions = eDir,
    descriptions = {
        "A spacious foyer. The walls are gilded and the floor is a mix of white and grey marble. There is a staircase leading up to the second floor, though it is blocked off by a rope.",
        "An casual library. The wall opposite the entrances are inset with shelves full of various books on a wide range of subjects. A lit fireplace sits between the two sets of shelves.",
        "A dimly lit parlor. There is a lit fireplace with a sette, atop a reddish ornate carpet, opposing it. A globe sits in the corner, and the Tudor family crest hangs on a nearby wall.",
        "A foggy smoking room. There is a colunal wall in the center of the room with a lit fireplace. The surrounding walls are adorned with the mounted heads of various wild animals.",
        "A quiet music room, you cannot hear the other guests from here. There is a grand piano in the center of the room, and a lit fireplace against the wall.",
        "An elegant banquet hall. There is a long table covered with an assortment of food and drink, with a wine fountain as the centerpiece."
    },
    neighbours = {
        { r = { 2 },    l = { 3, 4 } },
        { l = { 1 } },
        { u = { 4, 5 }, r = { 1 } },
        { r = { 1 },    d = { 3 },   l = { 5 } },
        { r = { 4 },    d = { 3 },   l = { 6 } },
        { r = { 5 } }
    }
}

return rooms
