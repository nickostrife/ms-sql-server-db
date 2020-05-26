CREATE PROCEDURE place_content_detail
@Place_Name varchar(50)
AS
BEGIN
select	p.Place_Name
		, p.AveragePriceID -- for price group code
		, p.lat -- for google map location
		, p.lon -- for google map location
		, p.Place_Description
		, AVG(ur.Rating) as avgRating
		, count(ur.Rating) as countRating
		, pc.Category_Name
		, ( oh.OpenTime + ' - ' + oh.CloseTime ) as BizHour
from Place as p
join UserReview as ur
on ur.PlaceID = p.ID
join PlaceCategory as pc
on pc.ID = p.PlaceCategoryID
join OpenHours as oh
on oh.PlaceID = p.ID
where p.Place_Name = @Place_Name
and oh.Weekday = datename(dw, getdate())

/* get photos url */
select PhotoURL
from PhotoPlaces as pp
join Place as p
on pp.PlaceID = p.ID
where p.Place_Name = @Place_Name

/* get rating popularity */
select Rating, SUM(Rating) as numRating
from UserReview as ur
join Place as p
on ur.PlaceID = p.ID
where p.Place_Name = @Place_Name;
group by Rating

END

EXEC place_content_detail @Place_Name = 'Think Thai Wisma 77';
