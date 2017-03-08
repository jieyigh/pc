package com.ds.record.vo;

import javax.validation.constraints.Max;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

public class BetInfoParams {
	
	public interface BetInfoTableParams{};
	public interface BetInfoSiteParams{};

	@NotEmpty(groups={BetInfoTableParams.class,BetInfoSiteParams.class},message = "id must not be null")
	@Pattern(groups={BetInfoTableParams.class,BetInfoSiteParams.class},regexp = "\\d*", message = "id must be a number")
	private String id;

	@NotEmpty(groups={BetInfoTableParams.class},message = "tableId must not be null")
	@Pattern(groups={BetInfoTableParams.class},regexp = "\\d*", message = "tableId must be a number")
	private String tableId;

	@NotEmpty(groups={BetInfoTableParams.class,BetInfoSiteParams.class},message = "num must not be null")
	@Pattern(groups={BetInfoTableParams.class,BetInfoSiteParams.class},regexp = "\\d*", message = "num must be a number")
	@Max(groups={BetInfoTableParams.class,BetInfoSiteParams.class},value=500,message="num must be less than or equal to 500")
	private String num;
	
	@NotEmpty(groups={BetInfoSiteParams.class},message = "siteId must not be null")
	@Pattern(groups={BetInfoSiteParams.class},regexp = "\\d*", message = "siteId must be a number")
	private String siteId;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}

	public String getNum() {
		return num;
	}

	public void setNum(String num) {
		this.num = num;
	}

	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}
	
	

}
