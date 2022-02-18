//
//  MIADataExamples.swift
//  MIAapp
//
//  Created by Sören Kirchner on 22.10.21.
//

import Foundation

extension Buildings {
    static func example() -> Self {
        let json = self.json
        return try! JSONDecoder().decode(Buildings.self, from: json.data(using: .utf8)!)
    }
}

extension Building {
    static func example() -> Self {
        return Buildings.example().data[0]
    }
}

extension Buildings {
    static let json = """
    {
    "meta": {
        "total_count": 199
    },
    "items": [
        {
            "id": 16,
            "meta": {
                "type": "buildings.BuildingPage",
                "detail_url": "https://modernism-in-architecture.org/api/v2/pages/16/",
                "html_url": "https://modernism-in-architecture.org/buildings/krochsiedlung-krochs-housing-estate/",
                "slug": "krochsiedlung-krochs-housing-estate",
                "first_published_at": "2020-06-18T23:47:53.905987Z"
            },
            "title": "Krochsiedlung (Kroch's housing estate)",
            "lat_long": "51.378277, 12.362067",
            "feed_image": {
                "id": 2,
                "meta": {
                    "type": "wagtailimages.Image",
                    "detail_url": "https://modernism-in-architecture.org/api/v2/images/2/",
                    "download_url": "https://modernism.s3.amazonaws.com/original_images/IMG_8390_Kopie.jpg"
                },
                "title": "Krochsiedlung_quer"
            }
        },
        {
            "id": 24,
            "meta": {
                "type": "buildings.BuildingPage",
                "detail_url": "https://modernism-in-architecture.org/api/v2/pages/24/",
                "html_url": "https://modernism-in-architecture.org/buildings/apartment-block-georg-schwarz-strae-95-99/",
                "slug": "apartment-block-georg-schwarz-strae-95-99",
                "first_published_at": "2020-06-21T21:22:03.885975Z"
            },
            "title": "Apartment block Georg-Schwarz-Straße 95-99",
            "lat_long": "51.346177, 12.316853",
            "feed_image": {
                "id": 3,
                "meta": {
                    "type": "wagtailimages.Image",
                    "detail_url": "https://modernism-in-architecture.org/api/v2/images/3/",
                    "download_url": "https://modernism.s3.amazonaws.com/original_images/IMG_8271.jpg"
                },
                "title": "Georg-Schwarz-Straße"
            }
        },
        {
            "id": 25,
            "meta": {
                "type": "buildings.BuildingPage",
                "detail_url": "https://modernism-in-architecture.org/api/v2/pages/25/",
                "html_url": "https://modernism-in-architecture.org/buildings/apartment-block-am-langen-felde-2-6/",
                "slug": "apartment-block-am-langen-felde-2-6",
                "first_published_at": "2020-06-21T21:38:10.582640Z"
            },
            "title": "Apartment block Am langen Felde 2-6",
            "lat_long": "51.345610, 12.316790",
            "feed_image": {
                "id": 4,
                "meta": {
                    "type": "wagtailimages.Image",
                    "detail_url": "https://modernism-in-architecture.org/api/v2/images/4/",
                    "download_url": "https://modernism.s3.amazonaws.com/original_images/IMG_8265.jpg"
                },
                "title": "Am-langen-Felde"
            }
        }
    ]
    }
    """
}
