//
//  NutritionModel.swift
//  Tap_Hoa_Online
//
//  Created by Nguyễn Quốc Hiếu on 18/04/2024.
//

import Foundation

struct NutritionModel: Identifiable, Equatable {
    var id: Int = 0
    var nutritionName: String = ""
    var nutritionValue: String = ""

    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "nutrition_id") as? Int ?? 0
        self.nutritionName = dict.value(forKey: "nutrition_name") as? String ?? ""
        self.nutritionValue = dict.value(forKey: "nutrition_value") as? String ?? ""
       
    }
    
    static func == (lhs: NutritionModel, rhs: NutritionModel) -> Bool {
        return lhs.id == rhs.id
    }
}
