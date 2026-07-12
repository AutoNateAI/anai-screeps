const profilesEl = document.querySelector('#profiles');
const form = document.querySelector('#register-form');
const statusEl = document.querySelector('#form-status');
const refresh = document.querySelector('#refresh');
const selectedProfileEl = document.querySelector('#selected-profile');
let selectedUsername = window.localStorage.getItem('screepsLocalProfile') || '';

function setStatus(message, error = false) {
  statusEl.textContent = message;
  statusEl.classList.toggle('error', error);
}

async function request(path, options = {}) {
  const response = await fetch(path, options);
  const data = await response.json();
  if (!response.ok || data.error) {
    throw new Error(data.error || `Request failed with ${response.status}`);
  }
  return data;
}

function renderProfiles(profiles) {
  if (!profiles.length) {
    profilesEl.innerHTML = '<p class="empty">No local profiles yet.</p>';
    return;
  }

  profilesEl.innerHTML = profiles.map(profile => {
    const selected = profile.username === selectedUsername;
    return `
    <article class="profile ${selected ? 'selected-card' : ''}">
      <div>
        <strong>${escapeHtml(profile.username || 'Unnamed')}</strong>
        <span>${escapeHtml(profile.email || '')}</span>
      </div>
      <div class="badge">CPU ${profile.cpu ?? '-'}</div>
      <button class="select-profile" type="button" data-username="${escapeHtml(profile.username || '')}">${selected ? 'Selected' : 'Select'}</button>
      <span>GCL ${profile.gcl ?? 0}</span>
      <span>${profile.active ? 'Active' : 'Inactive'}</span>
    </article>
  `;
  }).join('');
  updateSelectedProfile();
}

function escapeHtml(value) {
  return String(value).replace(/[&<>"']/g, char => ({
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#39;'
  })[char]);
}

async function loadProfiles() {
  profilesEl.innerHTML = '<p class="empty">Loading profiles...</p>';
  try {
    const data = await request('/local/api/profiles');
    renderProfiles(data.profiles || []);
  } catch (error) {
    profilesEl.innerHTML = `<p class="empty">${escapeHtml(error.message)}</p>`;
  }
}

function updateSelectedProfile() {
  selectedProfileEl.textContent = selectedUsername
    ? `Selected profile: ${selectedUsername}`
    : 'No profile selected yet.';
}

profilesEl.addEventListener('click', event => {
  const button = event.target.closest('[data-username]');
  if (!button) return;
  selectedUsername = button.dataset.username;
  window.localStorage.setItem('screepsLocalProfile', selectedUsername);
  loadProfiles();
});

form.addEventListener('submit', async event => {
  event.preventDefault();
  const formData = new FormData(form);
  const username = String(formData.get('username') || '').trim();
  const email = String(formData.get('email') || '').trim() || `${username}@local`;
  const password = String(formData.get('password') || '');
  const password2 = String(formData.get('password2') || '');

  if (password !== password2) {
    setStatus('Passwords do not match.', true);
    return;
  }

  setStatus('Creating profile...');
  try {
    const data = await request('/local/api/register', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username, email, password })
    });
    selectedUsername = data.profile.username;
    window.localStorage.setItem('screepsLocalProfile', selectedUsername);
    form.reset();
    setStatus(`Created ${data.profile.username}. Open Screeps: World and log in on localhost:21025.`);
    await loadProfiles();
  } catch (error) {
    setStatus(error.message, true);
  }
});

refresh.addEventListener('click', loadProfiles);
updateSelectedProfile();
loadProfiles();
