function z=sravn5(s1,s2,s3,s4,s5)
  if (s1==s2 && s3==s4 && s1~=s3 && s3~=s5 && s1~=s5) || (s1==s2 && s3==s5 && s1~=s3 && s3~=s4 && s1~=s4) || (s1==s2 && s4==s5 && s1~=s4 && s3~=s4 && s1~=s3)
    z=5;  
  else
    z=0;
  end
end