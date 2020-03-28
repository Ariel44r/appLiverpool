//
//  APIResponse.swift
//  AppLiverpool
//
//  Created by ARIEL DIAZ on 28/03/20.
//  Copyright © 2020 ARIEL DIAZ. All rights reserved.
//

import Foundation

class APIResponse: Wrappable {
    enum CodingKeys: String, CodingKey {
        case status="status"
        case pageType="pageType"
        case plpResults="plpResults"
    }
    var status: Status!
    var pageType: String!
    var plpResults: PLPResults!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        status      =   try values.decode(Status.self, forKey: .status)
        pageType    =   try values.decode(String.self, forKey: .pageType)
        plpResults  =   try values.decode(PLPResults.self, forKey: .plpResults)
    }
}

class Status: Wrappable {
    enum CodingKeys: String, CodingKey {
        case status="status"
        case statusCode="statusCode"
    }
    var status: String!
    var statusCode: Int!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        status      =   try values.decode(String.self, forKey: .status)
        statusCode  =   try values.decode(Int.self, forKey: .statusCode)
        
    }
}

class PLPResults: Wrappable {
    enum CodingKeys: String, CodingKey {
        case label="label"
        case plpState="plpState"
        case sortOptions="sortOptions"
        case refinementGroups="refinementGroups"
        case records="records"
    }
    var label: String!
    var plpState: PLPState!
    var sortOptions: [SortOption]!
    var refinementGroups: [RefinementGroup]!
    var records: [Record]!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        label       =   try values.decode(String.self, forKey: .label)
        plpState    =   try values.decode(PLPState.self, forKey: .plpState)
        sortOptions =   try values.decode([SortOption].self, forKey: .sortOptions)
        refinementGroups    =   try? values.decode([RefinementGroup].self, forKey: .refinementGroups)
        records     =   try? values.decode([Record].self, forKey: .records)
    }
}

class PLPState: Wrappable {
    enum CodingKeys: String, CodingKey {
        case categoryId="categoryId"
        case currentSortOption="currentSortOption"
        case currentFilters="currentFilters"
        case firstRecNum="firstRecNum"
        case lastRecNum="lastRecNum"
        case recsPerPage="recsPerPage"
        case totalNumRecs="totalNumRecs"
    }
    var categoryId: String!
    var currentSortOption: String!
    var currentFilters: String!
    var firstRecNum: Int!
    var lastRecNum: Int!
    var recsPerPage: Int!
    var totalNumRecs: Int!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        categoryId  =   try values.decode(String.self, forKey: .categoryId)
        currentSortOption   =   try values.decode(String.self, forKey: .currentSortOption)
        currentFilters  =   try values.decode(String.self, forKey: .currentFilters)
        firstRecNum     =   try values.decode(Int.self, forKey: .firstRecNum)
        lastRecNum      =   try values.decode(Int.self, forKey: .lastRecNum)
        recsPerPage     =   try values.decode(Int.self, forKey: .recsPerPage)
        totalNumRecs    =   try values.decode(Int.self, forKey: .totalNumRecs)
        
    }
}

class SortOption: Wrappable {
    enum CodingKeys: String, CodingKey {
        case sortBy="sortBy"
        case label="label"
    }
    var sortBy: String!
    var label: String!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        sortBy      =   try values.decode(String.self, forKey: .sortBy)
        label       =   try values.decode(String.self, forKey: .label)
        
    }
}

class RefinementGroup: Wrappable {
    enum CodingKeys: String, CodingKey {
        case name="name"
        case refinement="refinement"
        case multiSelect="multiSelect"
        case dimensionName="dimensionName"
    }
    var name: String!
    var refinement: [Refinement]!
    var multiSelect: Bool!
    var dimensionName: String!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        name        =   try values.decode(String.self, forKey: .name)
        refinement  =   try values.decode([Refinement].self, forKey: .refinement)
        multiSelect =   try values.decode(Bool.self, forKey: .multiSelect)
        dimensionName   =   try values.decode(String.self, forKey: .dimensionName)
    }
}

class Refinement: Wrappable {
    enum CodingKeys: String, CodingKey {
        case count="count"
        case label="label"
        case refinementId="refinementId"
        case selected="selected"
    }
    var count: Int!
    var label: String!
    var refinementId: String!
    var selected: Bool!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        count       =   try values.decode(Int.self, forKey: .count)
        label       =   try values.decode(String.self, forKey: .label)
        refinementId    =   try values.decode(String.self, forKey: .refinementId)
        selected    =   try values.decode(Bool.self, forKey: .selected)
        
    }
}

class Record: Wrappable {
    enum CodingKeys: String, CodingKey {
        case productId="productId"
        case skuRepositoryId="skuRepositoryId"
        case productDisplayName="productDisplayName"
        case productType="productType"
        case productRatingCount="productRatingCount"
        case productAvgRating="productAvgRating"
        case listPrice="listPrice"
        case minimumListPrice="minimumListPrice"
        case maximumListPrice="maximumListPrice"
        case promoPrice="promoPrice"
        case minimumPromoPrice="minimumPromoPrice"
        case maximumPromoPrice="maximumPromoPrice"
        case isHybrid="isHybrid"
        case marketplaceSLMessage="marketplaceSLMessage"
        case marketplaceBTMessage="marketplaceBTMessage"
        case isMarketPlace="isMarketPlace"
        case smImage="smImage"
        case lgImage="lgImage"
        case xlImage="xlImage"
        case groupType="groupType"
        case plpFlags="plpFlags"
        case variantsColor="variantsColor"
    }
    var productId: String!
    var skuRepositoryId: String!
    var productDisplayName: String!
    var productType: String!
    var productRatingCount: Int!
    var productAvgRating: Double!
    var listPrice: Double!
    var minimumListPrice: Double!
    var maximumListPrice: Double!
    var promoPrice: Double!
    var minimumPromoPrice: Double!
    var maximumPromoPrice: Double!
    var isHybrid: Bool!
    var marketplaceSLMessage: String!
    var marketplaceBTMessage: String!
    var isMarketPlace: Bool!
    var smImage: String!
    var lgImage: String!
    var xlImage: String!
    var groupType: String!
    var plpFlags: [PLPFlag]!
    var variantsColor: [VariantColor]!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        productId   =   try? values.decode(String.self, forKey: .productId)
        skuRepositoryId =   try? values.decode(String.self, forKey: .skuRepositoryId)
        productDisplayName  =   try? values.decode(String.self, forKey: .productDisplayName)
        productType     =   try? values.decode(String.self, forKey: .productType)
        productRatingCount  =   try? values.decode(Int.self, forKey: .productRatingCount)
        productAvgRating    =   try? values.decode(Double.self, forKey: .productAvgRating)
        listPrice       =   try? values.decode(Double.self, forKey: .listPrice)
        minimumListPrice    =   try? values.decode(Double.self, forKey: .minimumListPrice)
        maximumListPrice    =   try? values.decode(Double.self, forKey: .maximumListPrice)
        promoPrice      =   try? values.decode(Double.self, forKey: .promoPrice)
        minimumPromoPrice   =   try? values.decode(Double.self, forKey: .minimumPromoPrice)
        maximumPromoPrice   =   try? values.decode(Double.self, forKey: .maximumPromoPrice)
        isHybrid    =   try? values.decode(Bool.self, forKey: .isHybrid)
        marketplaceSLMessage    =   try? values.decode(String.self, forKey: .marketplaceSLMessage)
        marketplaceBTMessage    =   try? values.decode(String.self, forKey: .marketplaceBTMessage)
        isMarketPlace   =   try? values.decode(Bool.self, forKey: .isMarketPlace)
        smImage     =   try? values.decode(String.self, forKey: .smImage)
        lgImage     =   try? values.decode(String.self, forKey: .lgImage)
        xlImage     =   try? values.decode(String.self, forKey: .xlImage)
        groupType   =   try? values.decode(String.self, forKey: .groupType)
        plpFlags    =   try? values.decode([PLPFlag].self, forKey: .plpFlags)
        variantsColor   =   try? values.decode([VariantColor].self, forKey: .variantsColor)
        
    }
}

class PLPFlag: Wrappable { }
class VariantColor: Wrappable {
    enum CodingKeys: String, CodingKey {
        case colorName="colorName"
        case colorHex="colorHex"
        case colorImageURL="colorImageURL"
    }
    var colorName: String!
    var colorHex: String!
    var colorImageURL: String!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values  =   try decoder.container(keyedBy: CodingKeys.self)
        colorName   =   try values.decode(String.self, forKey: .colorName)
        colorHex    =   try values.decode(String.self, forKey: .colorHex)
        colorImageURL   =   try values.decode(String.self, forKey: .colorImageURL)
        
    }
}

