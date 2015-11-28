import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Window

w = 300
h = 200

{- zips two lists -}
zip : List a -> List b -> List (a,b)
zip xs ys =
  case (xs, ys) of
    ( x :: xs', y :: ys' ) ->
        (x,y) :: zip xs' ys'

    (_, _) ->
        []
        
linspace : Float -> Float -> Int -> List Float
linspace a b n =
  List.map (\x -> (toFloat x) * (b - a) / ((toFloat n) - 1.0) + a) [0..(n-1)]
        
border : Form
border =
  path [ (w,h), (w,-h), (-w,-h), (-w,h), (w,h) ]
    |> traced (solid blue)
    
   
range : List Float -> (Float, Float)
range x = (Maybe.withDefault 0.0 (List.minimum x), Maybe.withDefault 1.0 (List.maximum x))
    

axis : Int -> List Float -> List Float
axis len data =
  let
    (a, b) = range data
    l = toFloat len
  in
    List.map (\x -> l*(x-a)/b - l) data
  

{- generate fake data -}
t = linspace -6.28 6.28 1000
x = List.map sin t
data = zip (axis w t) (axis h x)

{- draws a point at the given location -}
point x y color =
    circle 4 |> filled color |> move (x, y)

points = List.map (\(x,y) -> point x y black) data
corners = [ point -w -h red
          , point w h red
          , point -w h red
          , point w -h red]


main = 
    collage (3*w) (3*h) (corners ++ points ++ [border])

