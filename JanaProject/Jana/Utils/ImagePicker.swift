//
//  ImagePicker.swift
//  Jana
//
//  Created by mona M on 30/05/1443 AH.
//

import Foundation
import YPImagePicker
import UIKit

class ImagePicker {
  
  static let shared = ImagePicker()
  
  let picker : YPImagePicker = {
    var config = YPImagePickerConfiguration()
    
  config.isScrollToChangeModesEnabled = true
  config.onlySquareImagesFromCamera = true
    config.usesFrontCamera = false
    config.showsPhotoFilters = false
    config.shouldSaveNewPicturesToAlbum = true
    config.albumName = "DefaultYPImagePickerAlbumName"
    config.startOnScreen = YPPickerScreen.photo
    config.screens = [.library , .photo]
    config.showsCrop = .none
    config.targetImageSize = YPImageSize.original
    config.hidesStatusBar = true
    config.hidesBottomBar = false
    config.preferredStatusBarStyle = UIStatusBarStyle.default
     
    config.library.options = nil
    config.library.onlySquare = false
    config.library.minWidthForItem = nil
    config.library.mediaType = YPlibraryMediaType.photo
    config.library.maxNumberOfItems = 1
    config.library.minNumberOfItems = 1
    config.library.numberOfItemsInRow = 4
    config.library.spacingBetweenItems = 1.0
    config.library.skipSelectionsGallery = false
    
    config.video.fileType = .mov
    config.video.recordingTimeLimit = 60.0
    config.video.libraryTimeLimit = 60.0
    config.video.minimumTimeLimit = 3.0
    config.video.trimmerMaxDuration = 60.0
    config.video.trimmerMinDuration = 3.0
    
    return YPImagePicker(configuration: config)
}()
  
  
  
  

}
