{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.BuletinNew where

import Import
import Yesod.Form.Bootstrap3

transcriptForm :: AForm Handler Transcript
transcriptForm = Transcript
    <$> areq textField "Title" Nothing
    <*> areq dayField "Data Recoltarii" Nothing
    <*> areq textareaField "Rezultat" Nothing
    <*> areq textareaField "Opinii"  Nothing
    <*> areq emailField "Email pacient" Nothing
    <*> areq textField "Tip Proba" Nothing
    <*> areq checkBoxField "Publicam Buletinul de analize?" Nothing

getBuletinNewR :: Handler Html
getBuletinNewR = do
    (widget, enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm transcriptForm
    defaultLayout $ do
        $(widgetFile "buletine/new")


postBuletinNewR :: Handler Html
postBuletinNewR = do
    ((res, widget), enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm transcriptForm
    case res of 
        FormSuccess transcript -> do
            transcriptId <- runDB $ insert transcript
            redirect $ BuletinDetaliuR transcriptId
        _ -> defaultLayout $(widgetFile "buletine/new")