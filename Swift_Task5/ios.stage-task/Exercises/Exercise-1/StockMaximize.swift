import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        
        var profit = 0
        var pricesArray = prices
        
        func countProfitBeforeMax() {
            
            guard let maxValue = pricesArray.max() else { return }
            
            for price in pricesArray {
                pricesArray.remove(at: 0)
                if price == maxValue { return }
                profit += maxValue - price
            }
        }
        
        while pricesArray.count != 0 {
            countProfitBeforeMax()
        }
        
        return profit
    }
}
