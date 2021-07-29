package com.pyd.entity;

public class User {
	private String username;
	private String password;
	private String phonenumber;
	private String email;
	private String identification;
	private String region;

	public String getDistrict() {
		return region;
	}

	public void setDistrict(String region) {
		this.region = region;
	}

	public String getPhonenumber() {
		return phonenumber;
	}

	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public User() {
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public String getIdentification() {
		return identification;
	}

	public void setIdentification(String identification) {
		this.identification = identification;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public User(String username, String password, String phonenumber, String email, String identification,
			String region) {
		super();
		this.username = username;
		this.password = password;
		this.phonenumber = phonenumber;
		this.email = email;
		this.identification = identification;
		this.region = region;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password + ", phonenumber=" + phonenumber + ", email="
				+ email + ", identification=" + identification + ", region=" + region + "]";
	}

}
