/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     2020/10/18 23:52:02                          */
/*==============================================================*/


drop index listing_cal_ration_FK;

drop table calendar;

drop index listings_PK;

drop table listings;

drop index listing_reviews_ration_FK;

drop table reviews;

drop index listiong_dreview_ration_FK;

drop table reviews_detail;

/*==============================================================*/
/* Table: calendar                                              */
/*==============================================================*/
create table calendar (
   listing_id           INT4                 not null,
   date                 DATE                 null,
   available            CHAR(1)              null,
   price                MONEY                null,
   adjusted_price       MONEY                null,
   minimum_nights       INT4                 null,
   maximum_nights       INT4                 null
);

/*==============================================================*/
/* Index: listing_cal_ration_FK                                 */
/*==============================================================*/
create  index listing_cal_ration_FK on calendar (
listing_id
);

/*==============================================================*/
/* Table: listings                                              */
/*==============================================================*/
create table listings (
   listing_id           INT4                 not null,
   name                 TEXT                 null,
   host_id              INT4                 null,
   host_name            VARCHAR(100)         null,
   neighbourhood        VARCHAR(100)         null,
   latitude             DECIMAL(9,5)         null,
   longitude            DECIMAL(9,5)         null,
   room_type            VARCHAR(100)         null
      constraint CKC_ROOM_TYPE_LISTINGS check (room_type is null or (room_type in ('Entire home/apt','Private room','Shared room','Hotel room'))),
   price                MONEY                null,
   minimum_nights       INT4                 null,
   number_of_reviews    INT4                 null,
   last_review          DATE                 null,
   reviews_per_month    DECIMAL(10,1)        null,
   calculated_host_listings_count INT4                 null,
   availability_365     INT4                 null,
   constraint PK_LISTINGS primary key (listing_id)
);

comment on table listings is
'Summary information and metrics for listings in Hong Kong (good for visualisations).';

/*==============================================================*/
/* Index: listings_PK                                           */
/*==============================================================*/
create unique index listings_PK on listings (
listing_id
);

/*==============================================================*/
/* Table: reviews                                               */
/*==============================================================*/
create table reviews (
   listing_id           INT4                 not null,
   review_date          DATE                 null
);

/*==============================================================*/
/* Index: listing_reviews_ration_FK                             */
/*==============================================================*/
create  index listing_reviews_ration_FK on reviews (
listing_id
);

/*==============================================================*/
/* Table: reviews_detail                                        */
/*==============================================================*/
create table reviews_detail (
   listing_id           INT4                 not null,
   review_id            INT4                 not null,
   review_date          DATE                 null,
   reviewer_id          INT4                 null,
   reviewer_name        VARCHAR(100)         null,
   comments             TEXT                 null
);

/*==============================================================*/
/* Index: listiong_dreview_ration_FK                            */
/*==============================================================*/
create  index listiong_dreview_ration_FK on reviews_detail (
listing_id
);

alter table calendar
   add constraint FK_CALENDAR_LISTING_C_LISTINGS foreign key (listing_id)
      references listings (listing_id)
      on delete restrict on update restrict;

alter table reviews
   add constraint FK_REVIEWS_LISTING_R_LISTINGS foreign key (listing_id)
      references listings (listing_id)
      on delete restrict on update restrict;

alter table reviews_detail
   add constraint FK_REVIEWS__LISTIONG__LISTINGS foreign key (listing_id)
      references listings (listing_id)
      on delete restrict on update restrict;

