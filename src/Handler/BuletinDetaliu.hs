{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.BuletinDetaliu where

import Import

getBuletinDetaliuR :: TranscriptId -> Handler Html
getBuletinDetaliuR transcriptId = do
    transcript <- runDB $ get404 transcriptId
    defaultLayout $ do
        $(widgetFile "buletine/detaliu")
