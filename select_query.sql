/* view general info */
select	Place_Name
		, AveragePriceID -- for price group code
		, lat -- for google map location
		, lon -- for google map location
		, Place_Description
from Place
where Place_Name = @Place_Name;

/* view photos */
select PhotoURL
from PhotoPlaces as pp
join Place as p
on pp.PlaceID = p.ID
where p.Place_Name = @Place_Name;

/* view rating n out of 4 */
select 	AVG(Rating) as avgRating
		, count(Rating) as countRating
from UserReview as ur
join Place as p
on ur.PlaceID = p.ID
where p.Place_Name = @Place_Name;

/* view rating popularity */
select Rating, SUM(Rating) as numRating
from UserReview as ur
join Place as p
on ur.PlaceID = p.ID
where p.Place_Name = @Place_Name
group by Rating;

/* view Place Category */
select Category_Name
from PlaceCategory as pc
join Place as p
on pc.ID = p.PlaceCategoryID
where p.Place_Name = @Place_Name;

/* view Open Hours */
select ( OpenTime + ' - ' + CloseTime ) as BizHour
from OpenHours as oh
join Place as p
on oh.PlaceID = p.ID
where p.Place_Name = @Place_Name;
