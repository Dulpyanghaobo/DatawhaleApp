//
//  DWFilter.swift
//  DatawhaleApp
//
//  Created by Hab Yang on 2022/2/24.
//

import Foundation
import CoreImage


enum FilterType {
    case person
    
}
struct DWFilter {
    
    static let shared = DWFilter.init()
    
    // MARK: - Func
    func filterSegment(inputImage: CIImage = CIImage.init(), filterType: FilterType) -> CIImage {
        
        let filter: CIFilter!
        
        switch filterType {
            /// 分割人像
        case .person:
            filter = CIFilter.personSegmentation()
        }
        /// 人物分割任务
        if (filter is CIPersonSegmentation) {
            guard let filter = filter as? CIPersonSegmentation else { return CIImage.init() }
            filter.inputImage = inputImage
        }
        /// 输出outputImage
        return filter.outputImage ?? CIImage.init()
    }
}
