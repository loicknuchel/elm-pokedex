module Components.Icon exposing (doc, starOutline, starSolid)

import ElmBook.Chapter as Chapter exposing (Chapter)
import Svg exposing (Svg, path, svg)
import Svg.Attributes exposing (class, clipRule, d, fill, fillRule, stroke, strokeLinecap, strokeLinejoin, strokeWidth, viewBox)


starOutline : String -> Svg msg
starOutline classes =
    outline classes "M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.563.563 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z"


starSolid : String -> Svg msg
starSolid classes =
    solid classes "M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.007 5.404.433c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.433 2.082-5.006z"


starMini : String -> Svg msg
starMini classes =
    mini classes "M10.868 2.884c-.321-.772-1.415-.772-1.736 0l-1.83 4.401-4.753.381c-.833.067-1.171 1.107-.536 1.651l3.62 3.102-1.106 4.637c-.194.813.691 1.456 1.405 1.02L10 15.591l4.069 2.485c.713.436 1.598-.207 1.404-1.02l-1.106-4.637 3.62-3.102c.635-.544.297-1.584-.536-1.65l-4.752-.382-1.831-4.401z"


outline : String -> String -> Svg msg
outline classes line =
    svg [ viewBox "0 0 24 24", class ("w-6 h-6 " ++ classes), fill "none", stroke "currentColor", strokeWidth "1.5" ]
        [ path [ strokeLinecap "round", strokeLinejoin "round", d line ] [] ]


solid : String -> String -> Svg msg
solid classes line =
    svg [ viewBox "0 0 24 24", class ("w-6 h-6 " ++ classes), fill "currentColor" ]
        [ path [ fillRule "evenodd", clipRule "evenodd", d line ] [] ]


mini : String -> String -> Svg msg
mini classes line =
    svg [ viewBox "0 0 20 20", class ("w-5 h-5 " ++ classes), fill "currentColor" ]
        [ path [ fillRule "evenodd", clipRule "evenodd", d line ] [] ]



-- DOCUMENTATION


doc : Chapter x
doc =
    Chapter.chapter "Icon"
        |> Chapter.renderComponentList
            [ ( "starOutline", starOutline "text-red-500" )
            , ( "starSolid", starSolid "text-red-500" )
            , ( "starMini", starMini "text-red-500" )
            ]
