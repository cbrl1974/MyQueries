select * from feeds.feeds where id = 9

select * from feeds.merchantFeeds where  feedid = 9 order by merchantid desc
select * from feeds.merchantFeeds where merchantid =589 and feedid = 9
select * from merchantfeeds where merchant_id = 1097


select * from feeds.FeedDumps 
where  RunDate > convert(date,getdate()-1) 
and feedid = 9
and merchantid = 1193
and identifier = 'ProductsInfo'

select top 50 * from feeds.FeedDumps
-- where identifier = 'FOA_ProductsInfo'
 order by RunDate desc

select p.id_product, p.manufmodel, co.id_cie, co.cie, mp.cost, mp.reducedPrice, mp.price from products p
inner join merchantProds mp on mp.ProductID = p.Id_product
inner join companies co on co.id_cie =p.manufid 
where mp.merchant_id = 1193
and p.manufid in (6183, 3181, 3182, 3184, 4226, 4227)
and p.manufmodel like '%A8010106%'


SELECT deptID,catID,percents,cents,reducedPercents,reducedCents
			FROM MerchantFeedPriceSettings
			WHERE merchant_id = 1097
			AND brand = 'coaster'

update top (1) feeds.merchantFeeds
set FeedOptionsJson = '{
    "AddFreight": false,
    "ApplyDfiDiscount": false,
    "ApplyVolumeDiscount": false,
    "WarehouseId": null,
    "FeedId": 9,
    "ManufacturerIds": [
        6183,
        3181,
        3182,
        3184,
        4226,
        4227
    ],
    "FeedInformations": null,
    "DownloaderSettings": {
        "CustomerId": 1046200
    },
    "ConverterSettings": null,
    "StatusProcessorSettings": {
        "ShowMissingProducts": true
    },
    "PricingModifierSettings": {
        "PricingType": 0,
        "DefaultPricingSettings": {
            "Id": 0,
            "Name": "",
            "RegularPriceFormulaValue": 0.0,
            "RegularPriceDefaultCents": null,
            "ReducedPriceFormulaValue": null,
            "ReducedPriceDefaultCents": null
        },
        "DepartmentsPricingSettings": [
            {
                "DepartmentId": 23,
                "Name": "Audio Video Furniture",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 58,
                        "Name": "TV Stands",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 248,
                        "Name": "TV Stand Accessories",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 318,
                        "Name": "Entertainment Centers",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 419,
                        "Name": "Entertainment Center Components",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            },
            {
                "DepartmentId": 26,
                "Name": "Bedroom",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 180,
                        "Name": "Bedding",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 181,
                        "Name": "Bed Components",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 182,
                        "Name": "Chests",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 183,
                        "Name": "Dressers",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 184,
                        "Name": "Dresser Mirrors",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 185,
                        "Name": "Armoires",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 186,
                        "Name": "Nightstands",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 187,
                        "Name": "Benches",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 262,
                        "Name": "Mattresses",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 272,
                        "Name": "Pillows",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 308,
                        "Name": "Bed Frames",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 331,
                        "Name": "Adjustable Bases",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 372,
                        "Name": "Foundations",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 587,
                        "Name": "Beds",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 607,
                        "Name": "Daybeds",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            },
            {
                "DepartmentId": 28,
                "Name": "Dining Room",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 178,
                        "Name": "Dining Tables",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 179,
                        "Name": "Dining Seating",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 209,
                        "Name": "China Cabinets",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 210,
                        "Name": "Buffets",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 431,
                        "Name": "Kitchen Islands and Carts",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 519,
                        "Name": "Dinettes",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            },
            {
                "DepartmentId": 30,
                "Name": "Home Accent",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 282,
                        "Name": "Mirrors",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 298,
                        "Name": "Home Decor",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 457,
                        "Name": "Rugs",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 527,
                        "Name": "Decorative Pillows",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 533,
                        "Name": "Sculptures",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 590,
                        "Name": "Bars",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            },
            {
                "DepartmentId": 29,
                "Name": "Home Office",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 134,
                        "Name": "Office Desks",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 267,
                        "Name": "Office Chairs",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 487,
                        "Name": "Filing Cabinets",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 657,
                        "Name": "Office Desk Components",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            },
            {
                "DepartmentId": 27,
                "Name": "Kids Bedroom",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 188,
                        "Name": "Kids Bed Components",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 189,
                        "Name": "Kids Dressers",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 190,
                        "Name": "Kids Dresser Mirrors",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 191,
                        "Name": "Kids Nightstands",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 192,
                        "Name": "Kids Desks",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 193,
                        "Name": "Kids Chests",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 196,
                        "Name": "Kids Bookshelves",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 407,
                        "Name": "Kids Seating",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 591,
                        "Name": "Kids Beds ",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            },
            {
                "DepartmentId": 25,
                "Name": "Living Room",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 87,
                        "Name": "Fireplaces",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 88,
                        "Name": "Home Theater Seating",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 175,
                        "Name": "Sleepers",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 208,
                        "Name": "Occasional Tables",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 258,
                        "Name": "Accent Cabinets",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 310,
                        "Name": "Sectionals",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 311,
                        "Name": "Sofas",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 312,
                        "Name": "Loveseats",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 313,
                        "Name": "Chairs",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 314,
                        "Name": "Recliners",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 315,
                        "Name": "Ottomans",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 316,
                        "Name": "Accent Chairs",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 319,
                        "Name": "Curios",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 473,
                        "Name": "Sectional Components",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 649,
                        "Name": "Futons",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            },
            {
                "DepartmentId": 58,
                "Name": "Outdoor Furniture",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null,
                "CategoriesPricingSettings": [
                    {
                        "Id": 447,
                        "Name": "Outdoor Seating",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 448,
                        "Name": "Outdoor Tables",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    },
                    {
                        "Id": 539,
                        "Name": "Outdoor Dining Sets",
                        "RegularPriceFormulaValue": null,
                        "RegularPriceDefaultCents": null,
                        "ReducedPriceFormulaValue": null,
                        "ReducedPriceDefaultCents": null
                    }
                ]
            }
        ],
        "GlobalRoundingActive": false,
        "GlobalRoundingType": 0,
        "GlobalRoundingLastDigit": 0,
        "GlobalModifierActive": false,
        "GlobalModifier": null,
        "RegularCostTypeId": 1,
        "ReducedCostTypeId": 1,
        "CollectionPricingType": 0,
        "CollectionDefaultPricingSettings": {
            "Id": 0,
            "Name": "",
            "RegularPriceFormulaValue": null,
            "RegularPriceDefaultCents": null,
            "ReducedPriceFormulaValue": null,
            "ReducedPriceDefaultCents": null
        },
        "CollectionDepartmentsPricingSettings": [
            {
                "Id": 23,
                "Name": "Audio Video Furniture",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            },
            {
                "Id": 26,
                "Name": "Bedroom",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            },
            {
                "Id": 28,
                "Name": "Dining Room",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            },
            {
                "Id": 30,
                "Name": "Home Accent",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            },
            {
                "Id": 29,
                "Name": "Home Office",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            },
            {
                "Id": 27,
                "Name": "Kids Bedroom",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            },
            {
                "Id": 25,
                "Name": "Living Room",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            },
            {
                "Id": 58,
                "Name": "Outdoor Furniture",
                "RegularPriceFormulaValue": null,
                "RegularPriceDefaultCents": null,
                "ReducedPriceFormulaValue": null,
                "ReducedPriceDefaultCents": null
            }
        ]
    },
    "BrandCategories": [
        {
            "BrandName": null,
            "BrandId": 3181,
            "SelectedDepartments": [
                25,
                29,
                28,
                26,
                27,
                58
            ],
            "Categories": [
                58,
                248,
                318,
                419,
                87,
                88,
                175,
                208,
                258,
                310,
                311,
                312,
                313,
                314,
                315,
                316,
                319,
                389,
                473,
                649,
                134,
                257,
                267,
                487,
                657,
                178,
                179,
                209,
                210,
                431,
                519,
                180,
                181,
                182,
                183,
                184,
                186,
                187,
                277,
                308,
                372,
                587,
                607,
                188,
                189,
                190,
                191,
                192,
                193,
                194,
                196,
                197,
                407,
                591,
                260,
                282,
                294,
                298,
                457,
                527,
                533,
                590,
                447,
                448,
                539,
                600
            ]
        },
        {
            "BrandName": null,
            "BrandId": 3182,
            "SelectedDepartments": [
                29,
                25,
                28,
                26,
                27
            ],
            "Categories": [
                58,
                318,
                419,
                134,
                267,
                657,
                175,
                208,
                310,
                311,
                312,
                313,
                314,
                315,
                316,
                473,
                178,
                179,
                209,
                210,
                431,
                180,
                181,
                182,
                183,
                184,
                185,
                186,
                187,
                587,
                188,
                190,
                282,
                457
            ]
        },
        {
            "BrandName": null,
            "BrandId": 3184,
            "SelectedDepartments": [
                25,
                28,
                26,
                27
            ],
            "Categories": [
                175,
                310,
                311,
                312,
                313,
                314,
                315,
                316,
                473,
                178,
                179,
                210,
                519,
                181,
                182,
                183,
                184,
                186,
                587,
                188,
                591
            ]
        },
        {
            "BrandName": null,
            "BrandId": 4226,
            "SelectedDepartments": [
                26
            ],
            "Categories": [
                262
            ]
        },
        {
            "BrandName": null,
            "BrandId": 4227,
            "SelectedDepartments": [
                26
            ],
            "Categories": [
                262,
                272,
                331,
                372
            ]
        }
    ],
    "IsActive": true,
    "DryRunActiveness": true,
    "PricingActive": true,
    "CollectionPricingActive": true,
    "DeleteMerchantProds": true,
    "AllBrandCatsActive": true,
    "AllowFeaturedItemsUpdate": false,
    "KeepMerchantProdWhenOutOfStock": false,
    "FeedName": "Ashley",
    "InventoryActive": false,
    "LocationName": null,
    "LocationNames": null,
    "AvailableLocations": [],
    "InventoryQtyOptions": {
        "IsActive": false,
        "MinimumQtyAvailable": 0,
        "IncludeNextShipmentQty": false,
        "NextShipmentMaxDays": 0
    },
    "AvailableCostTypes": [
        1
    ],
    "AvailablePricingTiers": [],
    "PricingTierId": null,
    "TierIdentifier": null,
    "TestingMerchantIdMappings": null
}'
where merchantid = 1193
and feedid = 9
