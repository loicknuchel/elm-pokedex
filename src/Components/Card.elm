module Components.Card exposing (BlogCard, TeamCard, doc, team, teamGrid)

import ElmBook.Chapter as Chapter exposing (Chapter)
import Html exposing (Html, a, div, h3, img, li, p, span, text, ul)
import Html.Attributes exposing (alt, attribute, class, href, src)


type alias TeamCard =
    { name : String
    , title : String
    , picture : String
    , pictureAlt : String
    }


team : TeamCard -> Html msg
team model =
    div [ class "space-y-4 group" ]
        [ div []
            [ img [ class "mx-auto h-20 w-20 rounded-full lg:h-24 lg:w-24 block group-hover:hidden", src model.picture, alt "" ] []
            , img [ class "mx-auto h-20 w-20 rounded-full lg:h-24 lg:w-24 hidden group-hover:block", src model.pictureAlt, alt "" ] []
            ]
        , div [ class "space-y-2 text-center" ]
            [ div [ class "text-xs font-medium lg:text-sm" ]
                [ h3 [ class "capitalize" ] [ text model.name ]
                , p [ class "text-indigo-600" ] [ text model.title ]
                ]
            ]
        ]


teamGrid : List (Html msg) -> Html msg
teamGrid children =
    div [ class "mx-auto max-w-7xl" ]
        [ div [ class "space-y-8 sm:space-y-12" ]
            [ ul [ attribute "role" "list", class "mx-auto grid grid-cols-2 gap-x-4 gap-y-8 sm:grid-cols-4 md:gap-x-6 lg:max-w-5xl lg:gap-x-8 lg:gap-y-12 xl:grid-cols-6" ]
                (children |> List.map (\c -> li [] [ c ]))
            ]
        ]


type alias BlogCard =
    { url : String
    , title : String
    , picture : String
    , category : String
    , description : String
    , authorUrl : String
    , authorName : String
    , authorPicture : String
    , authorDescription : String
    }


blog : BlogCard -> Html msg
blog model =
    div [ class "flex flex-col max-w-lg overflow-hidden rounded-lg shadow-lg" ]
        [ div [ class "flex-shrink-0" ] [ img [ class "h-48 w-full object-cover", src model.picture, alt "" ] [] ]
        , div [ class "flex flex-1 flex-col justify-between bg-white p-6" ]
            [ div [ class "flex-1" ]
                [ p [ class "text-sm font-medium text-indigo-600" ] [ a [ href model.url, class "hover:underline" ] [ text model.category ] ]
                , a [ href model.url, class "mt-2 block" ]
                    [ p [ class "text-xl font-semibold text-gray-900" ] [ text model.title ]
                    , p [ class "mt-3 text-base text-gray-500" ] [ text model.description ]
                    ]
                ]
            , div [ class "mt-6 flex items-center" ]
                [ div [ class "flex-shrink-0" ]
                    [ a [ href model.authorUrl ]
                        [ span [ class "sr-only" ] [ text model.authorName ]
                        , img [ class "h-10 w-10 rounded-full", src model.authorPicture, alt "" ] []
                        ]
                    ]
                , div [ class "ml-3" ]
                    [ p [ class "text-sm font-medium text-gray-900" ] [ a [ href model.authorUrl, class "hover:underline" ] [ text model.authorName ] ]
                    , div [ class "text-sm text-gray-500" ] [ text model.authorDescription ]
                    ]
                ]
            ]
        ]


blogGrid : List BlogCard -> Html msg
blogGrid items =
    div [ class "mx-auto max-w-7xl" ]
        [ div [ class "mx-auto grid max-w-lg gap-5 lg:max-w-none lg:grid-cols-3" ]
            (items |> List.map blog)
        ]



-- DOCUMENTATION


doc : Chapter x
doc =
    Chapter.chapter "Card"
        |> Chapter.renderComponentList
            [ ( "team", team sampleTeam1 )
            , ( "teamGrid", teamGrid (List.map team [ sampleTeam1, sampleTeam2, sampleTeam3, sampleTeam4, sampleTeam5, sampleTeam6, sampleTeam7, sampleTeam8, sampleTeam9 ]) )
            , ( "blog", blog sampleBlog1 )
            , ( "blogGrid", blogGrid [ sampleBlog1, sampleBlog2, sampleBlog3 ] )
            ]


sampleTeam1 : TeamCard
sampleTeam1 =
    { name = "Michael Foster"
    , title = "Co-Founder / CTO"
    , picture = "https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam2 : TeamCard
sampleTeam2 =
    { name = "Dries Vincent"
    , title = "Manager, Business Relations"
    , picture = "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam3 : TeamCard
sampleTeam3 =
    { name = "Lindsay Walton"
    , title = "Front-end Developer"
    , picture = "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam4 : TeamCard
sampleTeam4 =
    { name = "Courtney Henry"
    , title = "Designer"
    , picture = "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam5 : TeamCard
sampleTeam5 =
    { name = "Tom Cook"
    , title = "Director, Product Development"
    , picture = "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam6 : TeamCard
sampleTeam6 =
    { name = "Whitney Francis"
    , title = "Copywriter"
    , picture = "https://images.unsplash.com/photo-1517365830460-955ce3ccd263?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1517365830460-955ce3ccd263?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam7 : TeamCard
sampleTeam7 =
    { name = "Leonard Krasner"
    , title = "Senior Designer"
    , picture = "https://images.unsplash.com/photo-1519345182560-3f2917c472ef?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1519345182560-3f2917c472ef?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam8 : TeamCard
sampleTeam8 =
    { name = "Floyd Miles"
    , title = "Principal Designer"
    , picture = "https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleTeam9 : TeamCard
sampleTeam9 =
    { name = "Emily Selman"
    , title = "VP, User Experience"
    , picture = "https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    , pictureAlt = "https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
    }


sampleBlog1 : BlogCard
sampleBlog1 =
    { url = "#"
    , title = "Boost your conversion rate"
    , picture = "https://images.unsplash.com/photo-1496128858413-b36217c2ce36?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1679&q=80"
    , category = "Article"
    , description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Architecto accusantium praesentium eius, ut atque fuga culpa, similique sequi cum eos quis dolorum."
    , authorUrl = "#"
    , authorName = "Roel Aufderehar"
    , authorPicture = "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
    , authorDescription = "Mar 16, 2020 · 6 min read"
    }


sampleBlog2 : BlogCard
sampleBlog2 =
    { url = "#"
    , title = "How to use search engine optimization to drive sales"
    , picture = "https://images.unsplash.com/photo-1547586696-ea22b4d4235d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1679&q=80"
    , category = "Video"
    , description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Velit facilis asperiores porro quaerat doloribus, eveniet dolore. Adipisci tempora aut inventore optio animi., tempore temporibus quo laudantium."
    , authorUrl = "#"
    , authorName = "Daniela Metz"
    , authorPicture = "https://images.unsplash.com/photo-1550525811-e5869dd03032?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
    , authorDescription = "Mar 10, 2020 · 4 min read"
    }


sampleBlog3 : BlogCard
sampleBlog3 =
    { url = "#"
    , title = "Improve your customer experience"
    , picture = "https://images.unsplash.com/photo-1492724441997-5dc865305da7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1679&q=80"
    , category = "Case Study"
    , description = "Lorem ipsum dolor sit amet consectetur adipisicing elit. Sint harum rerum voluptatem quo recusandae magni placeat saepe molestiae, sed excepturi cumque corporis perferendis hic."
    , authorUrl = "#"
    , authorName = "Brenna Goyette"
    , authorPicture = "https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
    , authorDescription = "Feb 12, 2020 · 11 min read"
    }
