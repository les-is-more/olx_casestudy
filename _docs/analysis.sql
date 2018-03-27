SELECT 
    COUNT(`Seller.ID`), COUNT(DISTINCT `Seller.ID`)
FROM
    olx.retail;
# Total Rows in Retail : 155819
# No of Distinct Seller ID in Retail: 122400,
SELECT 
    `Category.ID`, COUNT(`Category.ID`)
FROM
    olx.retail
GROUP BY `Category.ID`;

# Show how we can prioritize which users should the Sales team approach first.
# First get the total volume per user.

CREATE VIEW olx.`test` AS
SELECT * FROM olx.b2c;

SELECT 
    *
FROM
    sys.session;

# deletes the entire `test1` table, before creating a new version of it with new data
DROP TABLE olx.`test1`;

CREATE TABLE olx.`test1` AS
SELECT 
    a.`SellID`, 
    (case when isnull(b.`TotalAds`) THen 0 else b.`TotalAds` end) as TotalAds,
    (case when isnull(b.`TotalBuyView`) THen 0 else b.`TotalBuyView` end) as TotalBuyView,
    (case when isnull(c.`BuyInitCont`) THen 0 else c.`BuyInitCont` end) as BuyInitCont,
	(case when isnull(d.`ServPurch`) THen 0 else d.`ServPurch` end) as ServPurch,
    (case when isnull(d.`ServVal`) THen 0 else d.`ServVal` end) as ServVal
FROM
(SELECT DISTINCT
    `Seller.ID` AS SellID
FROM
    olx.b2c) as A
LEFT JOIN
# Summarizing the viewers table for Ads and View metrics
(SELECT 
    `Seller.ID` AS SellID,
    SUM(`Number.of.Ads.Posted`) AS TotalAds,
    SUM(`Number.of.Buyers.Who.Viewed.the.Ads`) AS TotalBuyView 
FROM
    olx.viewers
GROUP BY `Seller.ID`
) as B
ON A.`SellID` = B.`SellID`

LEFT JOIN
# Summarizing the contacts table
(SELECT 
    `seller.id` as SellID,
    SUM(`Number.of.Buyers.Who.Initiated.Contact.within.3.days`) AS BuyInitCont
FROM
    olx.contacts
GROUP BY `seller.id`) as C
ON A.`SellID` = C.`SellID`

LEFT JOIN 
# Summarizing the pay table
(SELECT 
    `seller.id` AS SellID,
    SUM(`Number.of.Services.Purchased`) AS ServPurch,
    SUM(`Value.of.Services.Purchased`) AS ServVal
FROM
    olx.pay
GROUP BY `seller.id`) as D
ON A.`SellID` = D.`SellID`
;