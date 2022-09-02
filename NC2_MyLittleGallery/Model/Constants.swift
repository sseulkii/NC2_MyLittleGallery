//
//  Constants.swift
//  NC2_MyLittleGallery
//
//  Created by Seulki Lee on 2022/09/01.
//

import Foundation
import CoreML

class K {
    
    let segueChooseStyle = "chooseStyle"
    let segueShowImage = "showImage"
    let segueShowOnWall = "showOnWall"
    
    let cassatt = "Cassatt"
    let monet = "Monet"
    let renoir = "Renoir"
    let degas = "Degas"
    let manet = "Manet"
    let pissarro = "Pissarro"
    let morisot = "Morisot"
    let sisley = "Sisley"
    
    let artistNames = ["Monet", "Degas", "Renoir", "Manet", "Cassatt", "Sisley", "Morisot", "Pissarro"]
    
    let artStyleModels: [String: MLModel] = [
        "Monet": MyStyleTransferMonet().model,
        "Degas": MyStyleTransferDegas().model,
        "Renoir": MyStyleTransferRenoir().model,
        "Manet": MyStyleTransferManet().model,
        "Cassatt": MyStyleTransferCassatt().model,
        "Sisley": MyStyleTransferSisley().model,
        "Morisot": MyStyleTransferMorisot().model,
        "Pissarro": MyStyleTransferPissarro().model
    ]
    
    let backgroundColor1 = "backgroundcolor1"
    let backgroundColor2 = "backgroundcolor2"
    let fontColor = "fontcolor"
    let accentColor = "accentcolor-1"
    
    let waterLilies = ["waterlily1", "waterlily2"]
    let pickStyle = "waterlily1"
    let seeGallery = "waterlily2"
    
}
