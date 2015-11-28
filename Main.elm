import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Window

{- zips two lists -}
zip : List a -> List b -> List (a,b)
zip xs ys =
  case (xs, ys) of
    ( x :: xs', y :: ys' ) ->
        (x,y) :: zip xs' ys'

    (_, _) ->
        []

{- generate fake data -}
t = [0,10,20,30,40,50,60,70,80,90]
x = [10,30,50,30,10,20,30,20,15,10]
data = zip t x

{- draws a point at the given location -}
point x y =
    circle 4 |> filled black |> move (x, y)

points = List.map (\(x,y) -> point x y) data

main = 
    collage 200 200 points
