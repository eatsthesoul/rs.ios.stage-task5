import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres(asd: Int) -> Int {
        
        let foodMatrix = getMatrix(for: foods)
        let drinkMatrix = getMatrix(for: drinks)
        
        var returnedValue = 0
        
        for food in foodMatrix[foods.count] {
            for drink in drinkMatrix[drinks.count] {
                
                let minValue = min(food, drink)
                if minValue > returnedValue {
                    returnedValue = minValue
                }
            }
        }
        
        return returnedValue
    }
    
    func findMaxKilometres() -> Int {
        
        let foodMatrix = getMatrix(for: foods)
        let drinkMatrix = getMatrix(for: drinks)
        
        var returnedValue = 0
        
        for i in 1...maxWeight {
            let currentFoodVariation = foodMatrix[foods.count][i]
            let currentDrinkVariation = drinkMatrix[drinks.count][maxWeight - i]
            
            if min(currentFoodVariation, currentDrinkVariation) > returnedValue {
                returnedValue = min(currentFoodVariation, currentDrinkVariation)
            }
        }
        
        return returnedValue
    }

    
    func getMatrix(for array: [Supply]) -> [[Int]] {

        var values = [Int]()
        var weights = [Int]()
        
        for i in 0..<array.count {
            values.append(array[i].value)
            weights.append(array[i].weight)
        }

        var matrix = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: array.count + 1)
        
        for item in 1...values.count {
            for weight in 1...maxWeight {

                var maxValWithCurr = 0
                let maxValWithoutCurr = matrix[item - 1][weight]
                let weightOfCurr = weights[item - 1]

                if weight >= weightOfCurr {
                    let remainingWeight = weight - weightOfCurr
                    maxValWithCurr = matrix[item - 1][remainingWeight] + values[item - 1]
                }
                
                matrix[item][weight] = max(maxValWithCurr, maxValWithoutCurr)
            }
        }

        return matrix
    }
}
