-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/LUJHXr
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).
-- As Global App, the app is expected to support multiple languages nd region/country specific discounts, tax, etc.,
-- LocalisedLanguage is a comma separated value.
-- if LocalisedLanguage = blank,  the referene data entry in the table is all languagess.
-- Otherwise, the entry is applicable only to the language in comma separated values.
-- LocaliedCountryspefic is a comma separated value.
-- if LocaliedCountryspefic = blank,  the referene data entry in the table is all countries.
-- Otherwise, the entry is applicable only to the country name in the comma separated values.

SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [Country] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [Code] string  NOT NULL ,
    [Name] string  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED (
        [Code] ASC
    )
)

CREATE TABLE [Language] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [Code] string  NOT NULL ,
    [Name] string  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED (
        [Code] ASC
    )
)

CREATE TABLE [Currency] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [Code] string  NOT NULL ,
    [Name] string  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED (
        [Code] ASC
    )
)

CREATE TABLE [Localisation] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LanguageCode] string  NOT NULL ,
    [CountryCode] string  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_Localisation] PRIMARY KEY CLUSTERED (
        [LanguageCode] ASC,[CountryCode] ASC
    )
)

CREATE TABLE [Lookup] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    -- code is always English
    [Groupcode] string  NOT NULL ,
    -- code is always English
    [Code] string  NOT NULL ,
    -- Displaycode is language specific.
    [DisplayCode] string  NOT NULL ,
    [Name] string  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_Lookup] PRIMARY KEY CLUSTERED (
        [LocalisationId] ASC,[Groupcode] ASC,[Code] ASC
    )
)

-- Any Person associated with Business like Customer, Staff, Vendor, Maker, etc.,
CREATE TABLE [BusinessPerson] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    -- Lookup.GroupCode = BusinessPersonType
    -- Type = Lookup.Code [ Customer|Staff|Vendor|Maker|Teacher|etc.,]
    [LocalisationId] int  NOT NULL ,
    -- code is always English
    [Code] string  NOT NULL ,
    -- Displaycode is language specific.
    [DisplayCode] string  NOT NULL ,
    [LastName] string  NOT NULL ,
    [FirstName] string  NOT NULL ,
    [MiddleName] string  NOT NULL ,
    [Type] string  NOT NULL ,
    [BusinessPersonFamilyId] int  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_BusinessPerson] PRIMARY KEY CLUSTERED (
        [LocalisationId] ASC,[Code] ASC
    )
)

CREATE TABLE [PostalAddress] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    [BlockNo] string  NOT NULL ,
    [StreetName] string  NOT NULL ,
    [UnitNumber] string  NOT NULL ,
    [LandMark] string  NOT NULL ,
    [City] string  NOT NULL ,
    [State] string  NOT NULL ,
    [Country] string  NOT NULL ,
    [ZipCode] string  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_PostalAddress] PRIMARY KEY CLUSTERED (
        [Id] ASC,[LocalisationId] ASC
    )
)

-- Contact Details Personal Mobile,
-- Office Desk Phone, Emergency Number, FAX, Emails, Postal Addresses, etc.,
CREATE TABLE [ContactDetail] (
    -- Lookup.GroupCode = ContactDetailType
    -- Type = Lookup.Code [ PersonalMobile|OfficeMobile|FAX|PermanentAddress | CommunicationAddress|Etc.,]
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    [Type] string  NOT NULL ,
    -- nullable because it can be value or postaladdressid. Not a great idea thou.
    [value] string  NULL ,
    -- PostalAddress is treated as seperate contact type :)
    [PostalAddressId] int  NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_ContactDetail] PRIMARY KEY CLUSTERED (
        [Id] ASC,[LocalisationId] ASC
    )
)

CREATE TABLE [BusinessPersonContact] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [BusinessPersonId] int  NOT NULL ,
    [ContactDetailId] int  NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_BusinessPersonContact] PRIMARY KEY CLUSTERED (
        [BusinessPersonId] ASC,[ContactDetailId] ASC,[LocalisationId] ASC
    )
)

CREATE TABLE [Category] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    -- code is always English
    [Code] string  NOT NULL ,
    -- Displaycode is language specific.
    [DisplayCode] string  NOT NULL ,
    [Name] string  NOT NULL ,
    [Subcode] string  NOT NULL ,
    [SubName] sttring  NOT NULL ,
    [CategoryFamilyId] int  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTim  NOT NULL ,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED (
        [Id] ASC,[LocalisationId] ASC,[Code] ASC
    )
)

CREATE TABLE [Product] (
    -- BusinessPerson.Type = "Maker"
    -- MakerId = BusinessPerson.Id
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    -- code is always English
    [Code] string  NOT NULL ,
    -- Displaycode is language specific.
    [DisplayCode] string  NOT NULL ,
    [Name] string  NOT NULL ,
    [MakerId] int  NOT NULL ,
    [CategoryId] int  NOT NULL ,
    [version] string  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTim  NOT NULL ,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED (
        [LocalisationId] ASC,[Code] ASC
    )
)

CREATE TABLE [Inventory] (
    -- BusinessPerson.Type = "Vendor"
    -- MakerId = BusinessPerson.Id
    -- Lookup.GroupCode = UnitofMeasure
    -- UnitofMeasure = Lookup.Code [ KG/Feet/CM/Meters/etc.,]
    -- BusinessPerson.Type = "StoreHouse"
    -- MakerId = BusinessPerson.Id
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    [ProductId] int  NOT NULL ,
    [Vendorid] int  NOT NULL ,
    [Quantity] float  NOT NULL ,
    [Lotsize] float  NOT NULL ,
    [UnitofMeasure] string  NOT NULL ,
    [StoreId] int  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTim  NOT NULL ,
    CONSTRAINT [PK_Inventory] PRIMARY KEY CLUSTERED (
        [LocalisationId] ASC,[ProductId] ASC,[Vendorid] ASC
    )
)

CREATE TABLE [ProductDetail] (
    -- Lookup.GroupCode = ProductDetailKey
    -- Key = Lookup.Code [MemorySize|Color|Weight|DisplaySize|etc.,]
    -- Lookup.GroupCode = VisualType
    -- Type = Lookup.Code [pdf|doc|png|jpg|etc.,]
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    [ProductId] int  NOT NULL ,
    [Key] string  NOT NULL ,
    [Value] string  NOT NULL ,
    [VisualValue] blob  NOT NULL ,
    [VisualValueType] string  NOT NULL ,
    [SequenceOrder] int  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTim  NOT NULL ,
    CONSTRAINT [PK_ProductDetail] PRIMARY KEY CLUSTERED (
        [LocalisationId] ASC,[ProductId] ASC,[Key] ASC
    )
)

-- Prince and Discount vary betweeen different store locations
CREATE TABLE [ProductPrice] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [ProductId] int  NOT NULL ,
    [InventoryId] int  NOT NULL ,
    [EffectiveDate] date  NOT NULL ,
    [Price] decimal(18,6)  NOT NULL ,
    [Currency] string  NOT NULL ,
    [DiscountedPrice] decimal(18,6)  NOT NULL ,
    [DiscountPercentage] decimal(5,2)  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL 
)

-- Product Ad like Discounts, other offfers, etc,
CREATE TABLE [ProductCampaign] (
    [Id] int IDENTITY(1,1) NOT NULL ,
    [Code] string  NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    [ProductId] int  NOT NULL ,
    [Key] string  NOT NULL ,
    [Value] string  NOT NULL ,
    [VisualValue] blob  NOT NULL ,
    [VisualValueType] string  NOT NULL ,
    [SequenceOrder] int  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_ProductCampaign] PRIMARY KEY CLUSTERED (
        [Code] ASC,[LocalisationId] ASC,[ProductId] ASC,[Key] ASC
    )
)


-- Web page/App would have space to broadcast Ad.
-- Different Placeholder for different type of Campaign.
CREATE TABLE [ProductCampaignSchedule] (
    -- Lookup.GroupCode = ProductCampaignType
    -- Type = Lookup.Code [NewLaunch|SeasonalPromotion|Discount|etc.,]
    -- Campaign schedule follows the TimeZone defined.
    -- Lookup.GroupCode = TimeZone
    -- Type = Lookup.Code [UTC|IST|GMT|NYT|etc.,]
    -- Lookup.GroupCode = VisualType
    -- VisualValueType = Lookup.Code [pdf|doc|png|jpg|etc.,]
    [Id] int IDENTITY(1,1) NOT NULL ,
    [LocalisationId] int  NOT NULL ,
    [ProductCampaignId] int  NOT NULL ,
    [Type] string  NOT NULL ,
    [FromDateTime] DateTme  NOT NULL ,
    [ToDateTime] DateTme  NOT NULL ,
    [TimeZone] string  NOT NULL ,
    [Remarks] string  NOT NULL ,
    [EffectiveFrom] Date  NOT NULL ,
    [EffectiveTo] Date  NOT NULL ,
    [IsActive] Date  NOT NULL ,
    [CreatedBy] string  NOT NULL ,
    [UpdatedBy] string  NOT NULL ,
    [CreatedDateTime] DateTime  NOT NULL ,
    [UpdatedDateTime] DateTime  NOT NULL ,
    CONSTRAINT [PK_ProductCampaignSchedule] PRIMARY KEY CLUSTERED (
        [Id] ASC
    )
)


GO


ALTER TABLE [Localisation] WITH CHECK ADD CONSTRAINT [FK_Localisation_LanguageCode] FOREIGN KEY([LanguageCode])
REFERENCES [Language] ([Code])

ALTER TABLE [Localisation] CHECK CONSTRAINT [FK_Localisation_LanguageCode]

ALTER TABLE [Localisation] WITH CHECK ADD CONSTRAINT [FK_Localisation_CountryCode] FOREIGN KEY([CountryCode])
REFERENCES [Country] ([Code])

ALTER TABLE [Localisation] CHECK CONSTRAINT [FK_Localisation_CountryCode]

ALTER TABLE [Lookup] WITH CHECK ADD CONSTRAINT [FK_Lookup_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [Lookup] CHECK CONSTRAINT [FK_Lookup_LocalisationId]

ALTER TABLE [BusinessPerson] WITH CHECK ADD CONSTRAINT [FK_BusinessPerson_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [BusinessPerson] CHECK CONSTRAINT [FK_BusinessPerson_LocalisationId]

ALTER TABLE [BusinessPerson] WITH CHECK ADD CONSTRAINT [FK_BusinessPerson_Type] FOREIGN KEY([Type])
REFERENCES [Lookup] ([Code])

ALTER TABLE [BusinessPerson] CHECK CONSTRAINT [FK_BusinessPerson_Type]

ALTER TABLE [BusinessPerson] WITH CHECK ADD CONSTRAINT [FK_BusinessPerson_BusinessPersonFamilyId] FOREIGN KEY([BusinessPersonFamilyId])
REFERENCES [BusinessPerson] ([Id])

ALTER TABLE [BusinessPerson] CHECK CONSTRAINT [FK_BusinessPerson_BusinessPersonFamilyId]

ALTER TABLE [PostalAddress] WITH CHECK ADD CONSTRAINT [FK_PostalAddress_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [PostalAddress] CHECK CONSTRAINT [FK_PostalAddress_LocalisationId]

ALTER TABLE [ContactDetail] WITH CHECK ADD CONSTRAINT [FK_ContactDetail_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [ContactDetail] CHECK CONSTRAINT [FK_ContactDetail_LocalisationId]

ALTER TABLE [ContactDetail] WITH CHECK ADD CONSTRAINT [FK_ContactDetail_Type] FOREIGN KEY([Type])
REFERENCES [Lookup] ([Code])

ALTER TABLE [ContactDetail] CHECK CONSTRAINT [FK_ContactDetail_Type]

ALTER TABLE [ContactDetail] WITH CHECK ADD CONSTRAINT [FK_ContactDetail_PostalAddressId] FOREIGN KEY([PostalAddressId])
REFERENCES [PostalAddress] ([Id])

ALTER TABLE [ContactDetail] CHECK CONSTRAINT [FK_ContactDetail_PostalAddressId]

ALTER TABLE [BusinessPersonContact] WITH CHECK ADD CONSTRAINT [FK_BusinessPersonContact_BusinessPersonId] FOREIGN KEY([BusinessPersonId])
REFERENCES [BusinessPerson] ([Id])

ALTER TABLE [BusinessPersonContact] CHECK CONSTRAINT [FK_BusinessPersonContact_BusinessPersonId]

ALTER TABLE [BusinessPersonContact] WITH CHECK ADD CONSTRAINT [FK_BusinessPersonContact_ContactDetailId] FOREIGN KEY([ContactDetailId])
REFERENCES [ContactDetail] ([Id])

ALTER TABLE [BusinessPersonContact] CHECK CONSTRAINT [FK_BusinessPersonContact_ContactDetailId]

ALTER TABLE [BusinessPersonContact] WITH CHECK ADD CONSTRAINT [FK_BusinessPersonContact_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [BusinessPersonContact] CHECK CONSTRAINT [FK_BusinessPersonContact_LocalisationId]

ALTER TABLE [Category] WITH CHECK ADD CONSTRAINT [FK_Category_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [Category] CHECK CONSTRAINT [FK_Category_LocalisationId]

ALTER TABLE [Category] WITH CHECK ADD CONSTRAINT [FK_Category_CategoryFamilyId] FOREIGN KEY([CategoryFamilyId])
REFERENCES [Category] ([Id])

ALTER TABLE [Category] CHECK CONSTRAINT [FK_Category_CategoryFamilyId]

-- Free plan table limit reached. SUBSCRIBE for more.



CREATE INDEX [idx_Category_Subcode]
ON [Category] ([Subcode])

-- Free plan table limit reached. SUBSCRIBE for more.


ALTER TABLE [Product] WITH CHECK ADD CONSTRAINT [FK_Product_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [Product] CHECK CONSTRAINT [FK_Product_LocalisationId]

ALTER TABLE [Product] WITH CHECK ADD CONSTRAINT [FK_Product_MakerId] FOREIGN KEY([MakerId])
REFERENCES [BusinessPerson] ([Id])

ALTER TABLE [Product] CHECK CONSTRAINT [FK_Product_MakerId]

ALTER TABLE [Product] WITH CHECK ADD CONSTRAINT [FK_Product_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [Category] ([Id])

ALTER TABLE [Product] CHECK CONSTRAINT [FK_Product_CategoryId]

ALTER TABLE [Inventory] WITH CHECK ADD CONSTRAINT [FK_Inventory_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [Inventory] CHECK CONSTRAINT [FK_Inventory_LocalisationId]

ALTER TABLE [Inventory] WITH CHECK ADD CONSTRAINT [FK_Inventory_ProductId] FOREIGN KEY([ProductId])
REFERENCES [Product] ([Id])

ALTER TABLE [Inventory] CHECK CONSTRAINT [FK_Inventory_ProductId]

ALTER TABLE [Inventory] WITH CHECK ADD CONSTRAINT [FK_Inventory_Vendorid] FOREIGN KEY([Vendorid])
REFERENCES [BusinessPerson] ([Id])

ALTER TABLE [Inventory] CHECK CONSTRAINT [FK_Inventory_Vendorid]

ALTER TABLE [Inventory] WITH CHECK ADD CONSTRAINT [FK_Inventory_UnitofMeasure] FOREIGN KEY([UnitofMeasure])
REFERENCES [Lookup] ([Code])

ALTER TABLE [Inventory] CHECK CONSTRAINT [FK_Inventory_UnitofMeasure]

ALTER TABLE [Inventory] WITH CHECK ADD CONSTRAINT [FK_Inventory_StoreId] FOREIGN KEY([StoreId])
REFERENCES [BusinessPerson] ([Id])

ALTER TABLE [Inventory] CHECK CONSTRAINT [FK_Inventory_StoreId]

ALTER TABLE [ProductDetail] WITH CHECK ADD CONSTRAINT [FK_ProductDetail_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [ProductDetail] CHECK CONSTRAINT [FK_ProductDetail_LocalisationId]

ALTER TABLE [ProductDetail] WITH CHECK ADD CONSTRAINT [FK_ProductDetail_ProductId] FOREIGN KEY([ProductId])
REFERENCES [Product] ([Id])

ALTER TABLE [ProductDetail] CHECK CONSTRAINT [FK_ProductDetail_ProductId]

ALTER TABLE [ProductDetail] WITH CHECK ADD CONSTRAINT [FK_ProductDetail_Key] FOREIGN KEY([Key])
REFERENCES [Lookup] ([Code])

ALTER TABLE [ProductDetail] CHECK CONSTRAINT [FK_ProductDetail_Key]

ALTER TABLE [ProductDetail] WITH CHECK ADD CONSTRAINT [FK_ProductDetail_VisualValueType] FOREIGN KEY([VisualValueType])
REFERENCES [Lookup] ([Code])

ALTER TABLE [ProductDetail] CHECK CONSTRAINT [FK_ProductDetail_VisualValueType]

ALTER TABLE [ProductPrice] WITH CHECK ADD CONSTRAINT [FK_ProductPrice_ProductId] FOREIGN KEY([ProductId])
REFERENCES [Product] ([Id])

ALTER TABLE [ProductPrice] CHECK CONSTRAINT [FK_ProductPrice_ProductId]

ALTER TABLE [ProductPrice] WITH CHECK ADD CONSTRAINT [FK_ProductPrice_InventoryId] FOREIGN KEY([InventoryId])
REFERENCES [Inventory] ([Id])

ALTER TABLE [ProductPrice] CHECK CONSTRAINT [FK_ProductPrice_InventoryId]

ALTER TABLE [ProductPrice] WITH CHECK ADD CONSTRAINT [FK_ProductPrice_Currency] FOREIGN KEY([Currency])
REFERENCES [Currency] ([Code])

ALTER TABLE [ProductPrice] CHECK CONSTRAINT [FK_ProductPrice_Currency]

ALTER TABLE [ProductCampaign] WITH CHECK ADD CONSTRAINT [FK_ProductCampaign_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [ProductCampaign] CHECK CONSTRAINT [FK_ProductCampaign_LocalisationId]

ALTER TABLE [ProductCampaign] WITH CHECK ADD CONSTRAINT [FK_ProductCampaign_ProductId] FOREIGN KEY([ProductId])
REFERENCES [Product] ([Id])

ALTER TABLE [ProductCampaign] CHECK CONSTRAINT [FK_ProductCampaign_ProductId]

ALTER TABLE [ProductCampaign] WITH CHECK ADD CONSTRAINT [FK_ProductCampaign_Key] FOREIGN KEY([Key])
REFERENCES [Lookup] ([Code])

ALTER TABLE [ProductCampaign] CHECK CONSTRAINT [FK_ProductCampaign_Key]

ALTER TABLE [ProductCampaign] WITH CHECK ADD CONSTRAINT [FK_ProductCampaign_VisualValueType] FOREIGN KEY([VisualValueType])
REFERENCES [Lookup] ([Code])

ALTER TABLE [ProductCampaign] CHECK CONSTRAINT [FK_ProductCampaign_VisualValueType]

ALTER TABLE [ProductCampaignSchedule] WITH CHECK ADD CONSTRAINT [FK_ProductCampaignSchedule_LocalisationId] FOREIGN KEY([LocalisationId])
REFERENCES [Localisation] ([Id])

ALTER TABLE [ProductCampaignSchedule] CHECK CONSTRAINT [FK_ProductCampaignSchedule_LocalisationId]

ALTER TABLE [ProductCampaignSchedule] WITH CHECK ADD CONSTRAINT [FK_ProductCampaignSchedule_ProductCampaignId] FOREIGN KEY([ProductCampaignId])
REFERENCES [ProductCampaign] ([Id])

ALTER TABLE [ProductCampaignSchedule] CHECK CONSTRAINT [FK_ProductCampaignSchedule_ProductCampaignId]

ALTER TABLE [ProductCampaignSchedule] WITH CHECK ADD CONSTRAINT [FK_ProductCampaignSchedule_Type] FOREIGN KEY([Type])
REFERENCES [Lookup] ([Code])

ALTER TABLE [ProductCampaignSchedule] CHECK CONSTRAINT [FK_ProductCampaignSchedule_Type]

ALTER TABLE [ProductCampaignSchedule] WITH CHECK ADD CONSTRAINT [FK_ProductCampaignSchedule_TimeZone] FOREIGN KEY([TimeZone])
REFERENCES [Lookup] ([Code])

ALTER TABLE [ProductCampaignSchedule] CHECK CONSTRAINT [FK_ProductCampaignSchedule_TimeZone]

CREATE INDEX [idx_Category_Subcode]
ON [Category] ([Subcode])

COMMIT TRANSACTION QUICKDBD