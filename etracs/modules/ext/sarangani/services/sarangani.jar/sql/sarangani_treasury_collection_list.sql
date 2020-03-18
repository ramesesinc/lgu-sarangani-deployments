[getList]
select
	x.title, 
	x.idx, 
	sum(x.jan) as jan,
	sum(x.feb) as feb,
	sum(x.mar) as mar,
	sum(x.apr) as apr,
	sum(x.may) as may,
	sum(x.jun) as jun,
	sum(x.jul) as jul,
	sum(x.aug) as aug,
	sum(x.sep) as sep,
	sum(x.oct) as oct,
	sum(x.nov) as nov,
	sum(x.`dec`) as `dec`,
	sum(x.amount) as total
from (
	select
		st.title, 
		st.idx, 
		(case when month(cr.receiptdate) = 1 then cri.amount else 0 end) as jan,
		(case when month(cr.receiptdate) = 2 then cri.amount else 0 end) as feb,
		(case when month(cr.receiptdate) = 3 then cri.amount else 0 end) as mar,
		(case when month(cr.receiptdate) = 4 then cri.amount else 0 end) as apr,
		(case when month(cr.receiptdate) = 5 then cri.amount else 0 end) as may,
		(case when month(cr.receiptdate) = 6 then cri.amount else 0 end) as jun,
		(case when month(cr.receiptdate) = 7 then cri.amount else 0 end) as jul,
		(case when month(cr.receiptdate) = 8 then cri.amount else 0 end) as aug,
		(case when month(cr.receiptdate) = 9 then cri.amount else 0 end) as sep,
		(case when month(cr.receiptdate) = 10 then cri.amount else 0 end) as oct,
		(case when month(cr.receiptdate) = 11 then cri.amount else 0 end) as nov,
		(case when month(cr.receiptdate) = 12 then cri.amount else 0 end) as `dec`,
		cri.amount
	from liquidation liq
	inner join liquidation_remittance lr on liq.objid = lr.liquidationid
	inner join remittance rem on lr.objid = rem.objid
	inner join remittance_cashreceipt remc on rem.objid = remc.remittanceid
	inner join cashreceipt cr on remc.objid = cr.objid 
	inner join cashreceiptitem cri on cr.objid = cri.receiptid
	inner join itemaccount_tag tag on cri.item_objid = tag.acctid
	inner join sarangani_collection_tag st on tag.tag = st.objid 
	left join cashreceipt_void cv on cr.objid = cv.receiptid
	where cv.objid is null 
	and cr.receiptdate >= $P{startdate}
	and cr.receiptdate < $P{enddate}
	and cr.collector_objid like $P{collectorid}
)x 
group by x.title, x.idx order by x.idx ASC