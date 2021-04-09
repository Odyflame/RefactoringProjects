//
//  image.swift
//  MemoRefactoring
//
//  Created by Hanteo on 2021/04/06.
//
import UIKit

public struct Image {
  var image: UIImage
  var date: Date
}

extension Image {
  public init() {
    image = UIImage()
    date = Date()
  }
}
