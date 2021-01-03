{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.BuletinNew where

import Import

newtype UserId = UserId Int
    deriving Show


type Form a = Html -> MForm Handler (FormResult a, Widget)

data Transcript = Transcript
        { title                      :: Text
            , data_recoltarii        :: Day
            , rezultat               :: Textarea
            , pacient_id             :: Handler.BuletinNew.UserId
            , opinii_si_interpretari :: Textarea
        }
        deriving Show

form :: Handler.BuletinNew.UserId -> Handler.BuletinNew.Form Transcript
form userId = renderDivs $ Transcript
    <$> areq textField "Title" Nothing
    <*> areq dayField "Data Recoltarii" Nothing
    <*> areq textareaField "Rezultat" Nothing
    <*> pure userId
    <*> areq textareaField "Opinii si interpretari" Nothing

getBuletinNewR :: Handler Html
getBuletinNewR = do
    let userId = Handler.BuletinNew.UserId 5
    ((res, widget), enctype) <- runFormPost $ form userId
    defaultLayout $ do
        $(widgetFile "buletine/new")


postBuletinNewR :: Handler Html
postBuletinNewR = getBuletinNewR