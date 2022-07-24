-- DataCleaning Nashville housing

Select *
from DataCleaning.dbo.nashville_housing

-- Standardise Date Format

Select SaleDate, Convert(Date, SaleDate)
from DataCleaning.dbo.nashville_housing

Alter table DataCleaning.dbo.nashville_housing
Add SaleDateConverted Date

Update DataCleaning.dbo.nashville_housing
Set SaleDateConverted = CONVERT(Date, SaleDate)

Select *
from DataCleaning.dbo.nashville_housing

--------------------------------------------------------------------------------------

-- Populate Property Address

Select *
from DataCleaning.dbo.nashville_housing
-- where PropertyAddress is null
order by ParcelID


Select org.ParcelID, org.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(org.PropertyAddress, b.PropertyAddress)
from DataCleaning.dbo.nashville_housing org
Join DataCleaning.dbo.nashville_housing b
on org.ParcelID = b.ParcelID
and org.[UniqueID ] <> b.[UniqueID ]   -- not equal
where org.PropertyAddress is null

Update org
Set PropertyAddress = isnull(org.PropertyAddress, b.PropertyAddress)
from DataCleaning.dbo.nashville_housing org
Join DataCleaning.dbo.nashville_housing b
on org.ParcelID = b.ParcelID
and org.[UniqueID ] <> b.[UniqueID ]
where org.PropertyAddress is null

Select * 
from DataCleaning.dbo.nashville_housing
where PropertyAddress is null  -- check


--------------------------------------------------------------------------------------


-- Breaking out address into individual Columns (address, city, state)

Select 
substring(PropertyAddress, 1, Charindex(',', PropertyAddress)) as Address, 
CHARINDEX(',', PropertyAddress)   
from DataCleaning.dbo.nashville_housing


Select 
substring(PropertyAddress, 1, Charindex(',', PropertyAddress)-1) as Address
, SUBSTRING (PropertyAddress, Charindex(',', PropertyAddress)-+1, LEN(PropertyAddress)) 
from DataCleaning.dbo.nashville_housing

-----Create 2 new columns

Alter table DataCleaning.dbo.nashville_housing
Add PropertySplitAddress varchar(255);

Update DataCleaning.dbo.nashville_housing
Set PropertySplitAddress = Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

Alter table fDataCleaning.dbo.nashville_housing
Add PropertySplitCity varchar(255);

Update DataCleaning.dbo.nashville_housing
Set PropertySplitCity = Substring(PropertyAddress, Charindex(',', PropertyAddress) +1, LEN(PropertyAddress)) 


Select *
from DataCleaning.dbo.nashville_housing


--- seperating property address into two columns, address then seperate column for city


-----------------------------------------------------------------------------------------------------

Select OwnerAddress
from DataCleaning.dbo.nashville_housing

Select
PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
from DataCleaning.dbo.nashville_housing


Select
PARSENAME(Replace(OwnerAddress, ',', '.'), 3),
PARSENAME(Replace(OwnerAddress, ',', '.'), 2),
PARSENAME(Replace(OwnerAddress, ',', '.'), 1)
from DataCleaning.dbo.nashville_housing


-- Splitting parts of owner address up using parsename
-- Needed to replace comma with period as parsename only works with periods
-- ie picture as 1808 """""". Goodle"""". TN

-- Now need to add columns


Alter table DataCleaning.dbo.nashville_housing
Add OwnerSplitAddress varchar(255);

Update DataCleaning.dbo.nashville_housing
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'), 3)


Alter table DataCleaning.dbo.nashville_housing
Add OwnerSplitCity varchar(255);

Update DataCleaning.dbo.nashville_housing
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'), 2)


Alter table DataCleaning.dbo.nashville_housing
Add OwnerSplitState varchar(255);

Update DataCleaning.dbo.nashville_housing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'), 1)

Select *
from DataCleaning..nashville_housing

------------------------------------------------------------------------------------------------------

--- SoldasVacant columns having inconsistent use of Yes/No (sometimes using Y/N)

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
from DataCleaning.dbo.nashville_housing
Group by SoldAsVacant
order by 2

Select SoldAsVacant,
Case                                    
when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
Else SoldAsVacant
End
from DataCleaning.dbo.nashville_housing


Update DataCleaning..nashville_housing
Set SoldAsVacant = Case
when SoldAsVacant = 'Y' then 'Yes'
when SoldAsVacant = 'N' then 'No'
Else SoldAsVacant
End
from DataCleaning.dbo.nashville_housing

Select *
from DataCleaning.dbo.nashville_housing


---------------------------------------------------------------------------------------------------

-- Remove Duplicate rows in table

Select *
from DataCleaning.dbo.nashville_housing

With RowNumCTE As(
Select *,
row_num=Row_number()over(Partition by ParcelID,
PropertyAddress,
SalePrice,
SaleDate,
LegalReference
Order by ParcelID)
from DataCleaning.dbo.nashville_housing
)

--Delete from RowNumCTE
--where row_num > 1

--Select *
--from RowNumCTE
--where row_num > 1   -- selecting everything -- seeing empty table ie no more duplicates

Select * 
from RowNumCTE

-----------------------------------------------------------------------------------------------------

-- Delete unused columns

Select *
from DataCleaning.dbo.nashville_housing

Alter table DataCleaning..nashville_housing
Drop column OwnerAddress, TaxDistrict, PropertyAddress

Alter table DataCleaning..nashville_housing
Drop column SaleDate
