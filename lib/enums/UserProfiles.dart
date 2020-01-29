
enum UserProfiles {
  JUDGE,
  EMCEE,
  CHAIRMAN_OF_JUDGES,
  INVIGILATOR
}

UserProfiles getUserProfilesFromString(String profile) {
  profile = 'UserProfiles.$profile';
  try {
    return UserProfiles.values.firstWhere((f)=> f.toString() == profile);
  } catch (e) {
    // If there is no Profile, it will throw "Bad state: No element"
    return null;
  }
}