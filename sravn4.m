function z=sravn4(s1,s2,s3,s4,s5)
  if (s1==s2 && s2==s3 && s4~=s5 && s1~=s4 && s1~=s5) 
    z=4;  
  else
    z=0;
  end
end