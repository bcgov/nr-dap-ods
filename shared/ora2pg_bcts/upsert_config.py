UPSERT_CONFIG = {
    "V_SCALING_HISTORY": {
        "UPSERT_FLAG": "Y",
        "P_KEY_NAME": "sh_pk",
        "UPDATE_COLS": [
            "volume_scaled",
            "total_amount",
            "royalty_amount",
            "reserve_stmpg_amt",
            "bonus_stumpage_amt",
            "silv_levy_amount",
            "dev_levy_amount",
            "entry_timestamp",
            "entry_userid",
            "update_timestamp",
            "update_userid"
        ],
        "P_KEY_COLS": [
            "timber_mark",
            "scale_site",
            "scaling_period",
            "scale_species_code",
            "scale_product_code",
            "scale_grade_code",
            "billing_type_code"
        ]
    }
}
