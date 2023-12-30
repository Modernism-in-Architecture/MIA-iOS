//
//  BuildingDetail+Mock.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 28.12.23.
//

import Foundation

extension BuildingDetail {
    
    static let schunckMock = Self(
        id: 828,
        name: "Department store (Modehuis) Schunck",
        yearOfConstruction: "1934",
        address: "Bongerd 18",
        zipCode: "6411",
        city: "Heerlen",
        country: "Netherlands",
        cityCountry: "Heerlen, Netherlands",
        latitude: 50.88785218450188,
        longitude: 5.979353076537301,
        galleryImages: [
            "https://modernism.s3.amazonaws.com/original_images/thumbs/Schunck.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_170051777_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_163040614_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_162908365_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_162024492.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161757310_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161733391_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161638312_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161615005_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_160932940_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_160007477_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_155950926_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_155914759_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_162208059_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_162200064_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161927290_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161911375_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161841183_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_161338767_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_160913867_HDR.jpg.1200x0_q60.jpg",
            "https://modernism.s3.amazonaws.com/original_images/thumbs/IMG_20231030_160301549_HDR.jpg.1200x0_q60.jpg"
        ].compactMap(URL.init(string:)),
        subtitle: "A shopping paradise of the 1930's",
        todaysUse: "Multifunctional building",
        description: "The building's most impressive feature is the glass facade, which makes the building appear transparent, light and illuminates the market from the inside in the dark. The internal concrete structure extends over eight floors. The Schunck family with their four children once lived on the top two floors, designed as a penthouse. A restaurant area with a terrace for clients was set up on the highest level for visitors. The glass facade is is the most striking construction feature of this building. There is a distance of 50 cm between the outer glass facade and the supporting buildings's concrete construction. This distance, also thanks to hopper windows, serves to ventilate and cool the building, especially in summer. The internal construction is very open so that all products could be clearly seen. The shop had no storage rooms, so the goods were all on display, which was very unusual up to that years. The individual floors are supported by characteristic mushroom columns.",
        history: "The department store was built on a place called the Dirty Corner. The city wanted to quickly spruce up the square, so Peter Schunck took action. Construction of the building began on May 14, 1934 and opened on May 31, 1935. In addition to supplying the miners, style-conscious trends were also placed in the department store. The people started to call the house Glass Palace (Glaspaleis), which is the house's official name today. During World War II bombs destroyed the glass facade three times. When the Schunck company built a new department store, a pension fund moved in in 1970. The condition of the house deteriorated massively. As early as 1974, the building was used as a shopping center with a supermarket. Besides many other awards, the house became in 1995 National Monument. The main reason was the abandoned status of the building and some people, that wanted to demolish it. The municipality bought the house in 1997 and converted it into a cultural centre. In 1999 it was declared by the International Union of Architects as one of the best out of 1,000 buildings in the history of the 20th century's architecture. Three facades are made of glass facing east, north and west. The southern facade was once connected with the o&ouml;der Schunck store, which does not exist anymore. The south facade is completly visible today.",
        architects: [
            .init(
                id: 1309,
                lastName: "Peutz",
                firstName: "Frits",
                fullName: "Frits Peutz"
            )
        ],
        absoluteURL: .init(string: "https://modernism-in-architecture.org/buildings/department-store-modehuis-schunck/")!,
        buildingType: "Department store",
        attributedDescription: AttributedString("The building's most impressive feature is the glass facade, which makes the building appear transparent, light and illuminates the market from the inside in the dark. The internal concrete structure extends over eight floors. The Schunck family with their four children once lived on the top two floors, designed as a penthouse. A restaurant area with a terrace for clients was set up on the highest level for visitors. The glass facade is is the most striking construction feature of this building. There is a distance of 50 cm between the outer glass facade and the supporting buildings's concrete construction. This distance, also thanks to hopper windows, serves to ventilate and cool the building, especially in summer. The internal construction is very open so that all products could be clearly seen. The shop had no storage rooms, so the goods were all on display, which was very unusual up to that years. The individual floors are supported by characteristic mushroom columns."),
        attributedHistory: AttributedString("The department store was built on a place called the Dirty Corner. The city wanted to quickly spruce up the square, so Peter Schunck took action. Construction of the building began on May 14, 1934 and opened on May 31, 1935. In addition to supplying the miners, style-conscious trends were also placed in the department store. The people started to call the house Glass Palace (Glaspaleis), which is the house's official name today. During World War II bombs destroyed the glass facade three times. When the Schunck company built a new department store, a pension fund moved in in 1970. The condition of the house deteriorated massively. As early as 1974, the building was used as a shopping center with a supermarket. Besides many other awards, the house became in 1995 National Monument. The main reason was the abandoned status of the building and some people, that wanted to demolish it. The municipality bought the house in 1997 and converted it into a cultural centre. In 1999 it was declared by the International Union of Architects as one of the best out of 1,000 buildings in the history of the 20th century's architecture. Three facades are made of glass facing east, north and west. The southern facade was once connected with the o&ouml;der Schunck store, which does not exist anymore. The south facade is completly visible today."
        )
    )
}
