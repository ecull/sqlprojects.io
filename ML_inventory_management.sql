Select *
from Inventory_Management..[ML-Dataset]


       --Finding what states are involved in that study

Select Distinct State, Count(State)
from Inventory_Management..[ML-Dataset]
Group by State

-- 9 different locations


-----------------------------------------------------------------------------------------------------------

      -- Find distribution of jobs

Select *
from Inventory_Management..[ML-Dataset]

Select Distinct EmployeeJobTitle, Count(EmployeeJobTitle) as EmployeeCount
from Inventory_Management..[ML-Dataset]
Group by EmployeeJobTitle
Order by EmployeeCount desc

-- most common job is sales representative = 120


-----------------------------------------------------------------------------------------------------------


      -- Find product with Highest Standard Cost

Select *
from Inventory_Management..[ML-Dataset]

Select Distinct(ProductName), Round(Avg(ProductStandardCost),2) as AvgCost
from Inventory_Management..[ML-Dataset]
Group by ProductName
Order by AvgCost desc

-- 275 products
-- "G.Skill RipjawsX (F3-1600C9Q-32GXM) DDR3 32 GB" is the most expensive product = $75410 for company
-- "Western Digital WD2500AVVS" is cheapest = $12.63


-----------------------------------------------------------------------------------------------------------


          -- Find what product xhas the highest ListPrice

Select Distinct(ProductName), Round(AVG(ProductListPrice),2) as AvgListPrice
from Inventory_Management..[ML-Dataset]
Group by ProductName
Order by AvgListPrice desc

-- "G.Skill RipjawsX (F3-1600C9Q-32GXM) DDR3 32 GB" = $78180 (highest)
-- "Western Digital WD2500AVVS" = $15.55 (lowest)



-----------------------------------------------------------------------------------------------------------


        -- Find what product has the highest profitability percentage

Select Distinct(ProductName), Round(((AVG(ProductListPrice)-AVG(ProductStandardCost))/AVG(ProductListPrice))*100,2) as ProfitMarginPerc
from Inventory_Management..[ML-Dataset]
Group by ProductName
Order by ProfitMarginPerc desc

-- Highest Profit Margin = "Hynix (H15201504-8) Genuine DDR2 2 GB" at 40.08%
-- Intel SSDPECME040T401

Select *
from Inventory_Management..[ML-Dataset]
where ProductName = 'Intel SSDPECME040T401'   -- checking that profit is 0 therefore above formula is correct



-----------------------------------------------------------------------------------------------------------

     -- What Category is the most expensive

Select *
from Inventory_Management..[ML-Dataset]

Select Distinct CategoryName, Avg(ProductStandardCost) as AvgProduct
from Inventory_Management..[ML-Dataset]
Group by CategoryName
Order by AvgProduct desc

-- ON average RAM is most expensive = $5144.88



-----------------------------------------------------------------------------------------------------------

       -- Which category is most profitable

Select Distinct CategoryName, Avg(Profit) as Profit
from Inventory_Management..[ML-Dataset]
Group by CategoryName
Order by Profit desc

Select Distinct CategoryName, Round(((AVG(ProductListPrice)-AVG(ProductStandardCost))/AVG(ProductListPrice))*100,2) as CategoryProfitMargin
from Inventory_Management..[ML-Dataset]
Group by CategoryName
Order by CategoryProfitMargin desc

-- Video Card   = 20.1
-- Mother Board = 19.72
-- CPU = 18.03
-- RAM = 7.74
-- Storage = 3.14


-----------------------------------------------------------------------------------------------------------

      -- Find percentage of orders that are canceled

Select Status, Count(Status) as CountStatus, (Count(Status)*100/400.00) as PercStatus
from Inventory_Management..[ML-Dataset]
Group by Status
Order by PercStatus desc

-- 27.75% of orders are canceled


-----------------------------------------------------------------------------------------------------------


      -- Who is the newest employee

Select EmployeeName, EmployeeHireDate
from Inventory_Management..[ML-Dataset]
Order by EmployeeHireDate desc

-- Dee Randy is newest employee (2018)
-- Volk Colleen is longest staying employee (2020)


-----------------------------------------------------------------------------------------------------------


           ---- Find what employee brought in the most money

Select Distinct(EmployeeName), sum(ProductListPrice*OrderItemQuantity) as Revenue
from Inventory_Management..[ML-Dataset]
Group by EmployeeName
Order by 2 desc

   --- Newman Richard borught in most from sales = 11648820
   --- MacLennan Samuel brought in least from sales = 1274.25


-----------------------------------------------------------------------------------------------------------


           --- Find what warehouse ships the highest quantity


Select *
from Inventory_Management..[ML-Dataset]

Select Distinct(WarehouseName), Sum(OrderItemQuantity)
from Inventory_Management..[ML-Dataset]
Group by WarehouseName
Order by 2 desc

--- The warehouse in Mexico City ships the highest quantity = 4382


-----------------------------------------------------------------------------------------------------------


